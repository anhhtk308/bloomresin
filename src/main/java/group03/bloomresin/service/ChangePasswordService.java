package group03.bloomresin.service;

import org.springframework.stereotype.Service;

import group03.bloomresin.repository.UserRepository;

@Service
public class ChangePasswordService {
    private final UserRepository userRepository;

    public ChangePasswordService(UserRepository userRepository) {
        this.userRepository = userRepository;

    }

    public boolean checkEmailExist(String email) {
        return this.userRepository.existsByEmail(email);
    }
}
