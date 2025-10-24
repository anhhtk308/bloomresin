package group03.bloomresin.service.validator;

import java.util.Collections;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.security.core.userdetails.User;
import group03.bloomresin.service.UserService;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    private final UserService userService;

    public CustomUserDetailsService(UserService userService) {
        this.userService = userService;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        group03.bloomresin.domain.User user = this.userService.getUserByEmail(username)
                .orElseThrow(() -> new UsernameNotFoundException("Không tìm thấy tên người dùng"));
        return new User(
                user.getEmail(),
                user.getPassword(),
                user.isStatus(),
                true,
                true,
                user.isStatus(),
                Collections.singletonList(new SimpleGrantedAuthority("ROLE_" + user.getRole().getName())));
    }
}
