package group03.bloomresin.service;

import group03.bloomresin.domain.CustomOrder;
import group03.bloomresin.domain.User;
import group03.bloomresin.repository.CustomOrderRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CustomOrderService {

    private final CustomOrderRepository repository;

    public CustomOrderService(CustomOrderRepository repository) {
        this.repository = repository;
    }

    public CustomOrder save(CustomOrder order) {
        return repository.save(order);
    }

    public List<CustomOrder> findAll() {
        return repository.findAll();
    }

    // ✅ Quan trọng: Trả về Optional để controller gọi orElse, isEmpty, ...
    public Optional<CustomOrder> findById(Long id) {
        return repository.findById(id);
    }

    public List<CustomOrder> findByUser(User user) {
        return repository.findByUser_Id(user.getId());
    }

    public void deleteById(Long id) {
        repository.deleteById(id);
    }

    public List<CustomOrder> findByUserAndStatusNotIn(User user, List<String> statuses) {
        return repository.findByUserAndStatusNotIn(user, statuses);
    }
}
