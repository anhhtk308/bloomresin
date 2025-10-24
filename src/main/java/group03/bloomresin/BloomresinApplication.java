package group03.bloomresin;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;

@SpringBootApplication
public class BloomresinApplication {

    public static void main(String[] args) {
        // container
        ApplicationContext group04 = SpringApplication.run(BloomresinApplication.class, args);
        for (String s : group04.getBeanDefinitionNames()) {
            System.out.println(s);
        }
    }

}
