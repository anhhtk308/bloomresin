package group03.bloomresin.service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

import group03.bloomresin.domain.CartDetail;
import org.springframework.stereotype.Service;
import group03.bloomresin.domain.Order;
import group03.bloomresin.domain.OrderDetail;
import group03.bloomresin.domain.User;
import group03.bloomresin.domain.Cart;
import group03.bloomresin.repository.OrderDetailRepository;
import group03.bloomresin.repository.OrderRepository;

@Service
public class OrderService {
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public OrderService(
            OrderRepository orderRepository,
            OrderDetailRepository orderDetailRepository) {
        this.orderDetailRepository = orderDetailRepository;
        this.orderRepository = orderRepository;
    }

    public Order saveOrder(Order order) {
        return orderRepository.save(order);
    }

    public List<Order> fetchAllOrders() {
        return this.orderRepository.findAll();
    }

    public Optional<Order> fetchOrderById(long id) {
        return this.orderRepository.findById(id);
    }

    public void deleteOrderById(long id) {
        Optional<Order> orderOptional = this.fetchOrderById(id);
        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            List<OrderDetail> orderDetails = order.getOrderDetails();
            for (OrderDetail orderDetail : orderDetails) {
                this.orderDetailRepository.deleteById(orderDetail.getId());
            }
        }
        this.orderRepository.deleteById(id);
    }

    public void updateOrder(Order order) {
        Optional<Order> orderOptional = this.fetchOrderById(order.getId());
        if (orderOptional.isPresent()) {
            Order currentOrder = orderOptional.get();
            currentOrder.setStatus(order.getStatus());
            this.orderRepository.save(currentOrder);
        }
    }

    public List<Order> fetchOrderByUser(User user) {
        return this.orderRepository.findByUser(user);
    }

    public List<Order> getOrdersByUser(User user) {
        return orderRepository.findByUser(user);
    }

    public List<Order> getOrdersByUserAndStatus(User user, String status) {
        return orderRepository.findByUserAndStatus(user, status);
    }

    public List<Order> getOrdersByUserAndStatusNotIn(User user, List<String> excludedStatuses) {
        return orderRepository.findByUserAndStatusNotIn(user, excludedStatuses);
    }

    public List<Order> fetchOrdersByCustomerId(long customerId) {
        return orderRepository.findByUser_Id(customerId);
    }

    public Map<Integer, Double> getMonthlyRevenueForYear(int year) {
        List<Order> orders = orderRepository.findByStatus("COMPLETE");
        Map<Integer, Double> monthlyRevenue = new HashMap<>();

        for (Order order : orders) {
            if (order.getOrderDate().getYear() == year) {
                int month = order.getOrderDate().getMonthValue();
                monthlyRevenue.put(month, monthlyRevenue.getOrDefault(month, 0.0) + order.getTotalPrice());
            }
        }
        return monthlyRevenue;
    }

    public Set<Integer> getYearsWithData() {
        List<Order> orders = orderRepository.findByStatus("COMPLETE");
        return orders.stream()
                .map(order -> order.getOrderDate().getYear())
                .collect(Collectors.toCollection(TreeSet::new));
    }

    public List<Order> getOrdersByUserAndStatusNot(User user, String excludedStatus) {
        return orderRepository.findByUserAndStatusNot(user, excludedStatus);
    }

    public Order createPendingBankTransferOrder(User user, Cart cart, String note,
                                                String address, String receiverName, String receiverPhone, double totalPrice) {
        Order order = new Order();
        order.setNote(note);
        order.setReceiverAddress(address);
        order.setReceiverName(receiverName);
        order.setReceiverPhone(receiverPhone);
        order.setOrderDate(LocalDateTime.now());
        order.setTotalPrice(totalPrice);
        order.setPaymentMethod("BANK_TRANSFER");
        order.setStatus("PENDING");
        order.setUser(user);

        List<OrderDetail> orderDetails = new ArrayList<>();
        for (CartDetail cartDetail : cart.getCartDetails()) {
            OrderDetail detail = new OrderDetail();
            detail.setProduct(cartDetail.getProduct());
            detail.setQuantity((int) cartDetail.getQuantity());
            detail.setPrice(cartDetail.getPrice());
            detail.setOrder(order);
            orderDetails.add(detail);
        }

        order.setOrderDetails(orderDetails);
        return orderRepository.save(order);
    }

    public Optional<Order> getOrderById(Long id) {
        return orderRepository.findById(id);
    }
    public long countNewOrders() {
        return orderRepository.countByStatus("PENDING");
    }

    public Order save(Order order) {
        return orderRepository.save(order);
    }
}

