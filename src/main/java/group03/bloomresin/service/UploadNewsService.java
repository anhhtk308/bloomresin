package group03.bloomresin.service;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

@Service
public class UploadNewsService {
    // ✅ Lưu trực tiếp vào webapp/resources/images để JSP hiển thị ngay
    private static final String UPLOAD_DIR = "src/main/webapp/resources/images/";

    public String handleSaveUploadFile(MultipartFile file, String targetFolder) {
        if (file.isEmpty()) {
            return "";
        }

        try {
            // Tạo thư mục nếu chưa có
            Path uploadPath = Paths.get(UPLOAD_DIR + targetFolder);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            // Tạo tên file duy nhất
            String fileName = UUID.randomUUID() + "-" + file.getOriginalFilename();

            // Lưu file vào thư mục
            Path filePath = uploadPath.resolve(fileName);
            Files.copy(file.getInputStream(), filePath);

            // ✅ Trả về URL để JSP gọi được ngay
            return "/images/" + targetFolder + "/" + fileName;
        } catch (IOException e) {
            throw new RuntimeException("Lỗi khi upload file: " + e.getMessage(), e);
        }
    }
}
