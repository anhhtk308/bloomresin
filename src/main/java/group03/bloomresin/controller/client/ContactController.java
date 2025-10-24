package group03.bloomresin.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ContactController {

    @GetMapping("/contact")
    public String showContactPage() {
        return "customer/contact/contact";
    }
}
