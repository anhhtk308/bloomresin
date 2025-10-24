package group03.bloomresin.util;

public class StatusTranslator {
    public static String translate(String status) {
        return switch (status) {
            case "PENDING" -> "Chờ xử lý";
            case "PROCESSING" -> "Đang xử lý";
            case "COMPLETED" -> "Hoàn tất";
            case "CANCELLED" -> "Đã hủy";
            case "CONFIRMED" -> "Đã xác nhận";
            case "SHIPPING" -> "Đang vận chuyển";
            case "DELIVERED" -> "Đã giao hàng";
            default -> "Không rõ";
        };
    }
}

