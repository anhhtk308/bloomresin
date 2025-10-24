package group03.bloomresin.controller.admin;

import group03.bloomresin.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.util.Set;
import java.time.Year;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private final OrderService orderService;

    @Autowired
    public AdminController(OrderService orderService) {
        this.orderService = orderService;
    }

    @GetMapping
    public String showStatistics(@RequestParam(value = "year", required = false) Integer year, Model model) {
        if (year == null) {
            year = Year.now().getValue();
        }
        System.out.println("Received year: " + year);
        Map<Integer, Double> monthlyRevenue = orderService.getMonthlyRevenueForYear(year);
        Set<Integer> yearsWithData = orderService.getYearsWithData();

        model.addAttribute("monthlyRevenue", monthlyRevenue);
        model.addAttribute("selectedYear", year);
        model.addAttribute("yearsWithData", yearsWithData);

        return "admin/homepage/statistics";
    }
}
