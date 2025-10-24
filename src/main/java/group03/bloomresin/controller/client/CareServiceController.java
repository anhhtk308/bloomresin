package group03.bloomresin.controller.client;

//import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class CareServiceController {
    
    @GetMapping("/careservice")
    public String showCareService() {
        return "customer/careservice/careservice";
    }
    
    @GetMapping("/book-service/{type}")
    public String bookService(@PathVariable String type, Model model) {
        model.addAttribute("serviceType", type);
        return "book-service";
    }
}