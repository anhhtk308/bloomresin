package group03.bloomresin.service;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.*;

@Service
public class UploadService {

    public String handleSaveUploadFile(MultipartFile multipartFile, String folder) {
        try {
            String originalFileName = multipartFile.getOriginalFilename();
            String fileName = System.currentTimeMillis() + "_" + originalFileName;

            // ✅ Lưu trực tiếp vào webapp để có thể truy cập ảnh qua JSP
            String uploadDir = new java.io.File("src/main/webapp/resources/images/" + folder).getAbsolutePath();

            Path uploadPath = Paths.get(uploadDir);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath); // ✅ Tạo thư mục nếu chưa có
            }

            try (InputStream inputStream = multipartFile.getInputStream()) {
                Path filePath = uploadPath.resolve(fileName);
                Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
            }

            return fileName;
        } catch (IOException e) {
            throw new RuntimeException("Lỗi khi upload file: " + e.getMessage(), e);
        }
    }
}
