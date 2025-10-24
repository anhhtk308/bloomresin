package group03.bloomresin.service;

import group03.bloomresin.domain.Order;
import group03.bloomresin.domain.OrderDetail;
import group03.bloomresin.domain.ProductReview;
import group03.bloomresin.repository.OrderDetailRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class OrderDetailService {
    private final OrderDetailRepository orderDetailRepository;

    public OrderDetailService(OrderDetailRepository orderDetailRepository) {
        this.orderDetailRepository = orderDetailRepository;
    }

    public Optional<OrderDetail> findById(long id) {
        return orderDetailRepository.findById(id);
    }

    public Optional<OrderDetail> getById(long id) {
        return orderDetailRepository.findById(id);
    }

    public List<OrderDetail> findByProductId(long productId) {
        return orderDetailRepository.findByProductId(productId);
    }

    public List<OrderDetail> findByOrderId(long orderId) {
        return orderDetailRepository.findByOrderId(orderId);
    }

    public boolean hasReview(OrderDetail orderDetail) {
        return orderDetail.getProductReview() != null;
    }

    public void updateProductReview(OrderDetail orderDetail, ProductReview review) {
        orderDetail.setProductReview(review);
        orderDetailRepository.save(orderDetail);
    }

    public OrderDetail save(OrderDetail orderDetail) {
        return orderDetailRepository.save(orderDetail);
    }
}
