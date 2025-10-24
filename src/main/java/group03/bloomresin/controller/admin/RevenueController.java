package group03.bloomresin.controller.admin;

import group03.bloomresin.domain.UserLoginLog;
import group03.bloomresin.repository.OrderDetailRepository;
import group03.bloomresin.repository.OrderRepository;
import group03.bloomresin.repository.UserLoginLogRepository;
import group03.bloomresin.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin/statistics")
public class RevenueController {

    @Autowired
    private OrderRepository orderRepo;

    @Autowired
    private OrderDetailRepository orderDetailRepo;

    @Autowired
    private UserLoginLogRepository loginLogRepo;

    @Autowired
    private UserService userService;

    @GetMapping({"", "/"})
    public String getStatistics(
            @RequestParam(value = "year", required = false) Integer year,
            @RequestParam(value = "month", required = false) Integer month,
            Model model) {

        // --- Chọn tháng & năm ---
        LocalDate now = LocalDate.now();
        int selectedYear = (year != null) ? year : now.getYear();
        int selectedMonth = (month != null) ? month : now.getMonthValue();

        YearMonth ym = YearMonth.of(selectedYear, selectedMonth);
        int daysInMonth = ym.lengthOfMonth();

        LocalDate startDate = LocalDate.of(selectedYear, selectedMonth, 1);
        LocalDate endDate = startDate.withDayOfMonth(daysInMonth);

        // --- Chuyển LocalDate sang LocalDateTime ---
        LocalDateTime startDateTime = startDate.atStartOfDay();
        LocalDateTime endDateTime = endDate.atTime(23, 59, 59);

        // ==========================
        // 1️⃣ Doanh thu theo ngày
        // ==========================
        List<Object[]> revenueResults = orderRepo.getRevenueByDayBetween(startDateTime, endDateTime);
        Map<Integer, Double> revenueByDay = new LinkedHashMap<>();
        for (int d = 1; d <= daysInMonth; d++) revenueByDay.put(d, 0.0);

        if (revenueResults != null) {
            for (Object[] row : revenueResults) {
                if (row[0] != null && row[1] != null) {
                    revenueByDay.put(((Number) row[0]).intValue(), ((Number) row[1]).doubleValue());
                }
            }
        }
        double totalRevenue = revenueByDay.values().stream().mapToDouble(Double::doubleValue).sum();

        // ==========================
        // 2️⃣ Top sản phẩm bán chạy
        // ==========================
        List<Object[]> productSales = orderDetailRepo.getTopProductsBetweenDates(startDateTime, endDateTime);
        Map<String, Integer> topProducts = new LinkedHashMap<>();
        int othersTotal = 0;

        if (productSales != null) {
            for (int i = 0; i < productSales.size(); i++) {
                Object[] row = productSales.get(i);
                String name = (String) row[0];
                int qty = ((Number) row[1]).intValue();
                if (i < 5) topProducts.put(name, qty);
                else othersTotal += qty;
            }
        }
        if (othersTotal > 0) topProducts.put("Khác", othersTotal);

        // ==========================
// 3️⃣ Lượt đăng nhập theo ngày
// ==========================
        Map<Integer, Integer> loginCountByDay = new LinkedHashMap<>();
        for (int d = 1; d <= daysInMonth; d++) loginCountByDay.put(d, 0);

// Lấy dữ liệu trực tiếp từ DB cho toàn bộ tháng
        List<Object[]> loginResults = loginLogRepo.countLoginsBetweenDates(startDateTime, endDateTime);
        if (loginResults != null) {
            for (Object[] row : loginResults) {
                if (row[0] != null && row[1] != null) {
                    int day = ((Number) row[0]).intValue();
                    int count = ((Number) row[1]).intValue();
                    loginCountByDay.put(day, count);
                }
            }
        }

        long totalLogins = loginCountByDay.values().stream().mapToLong(Integer::longValue).sum();

        // ==========================
        // 4️⃣ Tổng đơn hàng
        // ==========================
        long totalOrders = orderRepo.countOrdersInMonthBetween(startDateTime, endDateTime);

        // ==========================
        // 5️⃣ Tổng khách hàng
        // ==========================
        long totalCustomers = userService.countCustomers();

        // ==========================
        // 6️⃣ Tổng nhân viên
        // ==========================
        long totalEmployees = userService.countEmployees();

        // ==========================
        // 7️⃣ Năm có dữ liệu
        // ==========================
        List<Integer> yearsWithData = orderRepo.findYearsWithData();

        // ==========================
        // 8️⃣ Thêm vào model
        // ==========================
        model.addAttribute("selectedYear", selectedYear);
        model.addAttribute("selectedMonth", selectedMonth);
        model.addAttribute("yearsWithData", yearsWithData);

        model.addAttribute("revenueByDay", revenueByDay);
        model.addAttribute("topProducts", topProducts);
        model.addAttribute("loginCountByDay", loginCountByDay);

        model.addAttribute("totalRevenue", totalRevenue);
        model.addAttribute("totalOrders", totalOrders);
        model.addAttribute("totalCustomers", totalCustomers);
        model.addAttribute("totalEmployees", totalEmployees);
        model.addAttribute("totalLogins", totalLogins);

        return "admin/homepage/statistics"; // JSP
    }
}
