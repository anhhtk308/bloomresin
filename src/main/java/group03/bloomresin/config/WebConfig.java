package group03.bloomresin.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.io.File;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // ✅ Lấy đường dẫn tuyệt đối tới src/main/webapp/resources/images/
        String basePath = new File("src/main/webapp/resources/images/").getAbsolutePath();

        registry.addResourceHandler("/images/avatar/**")
                .addResourceLocations("file:" + basePath + "/avatar/");

        registry.addResourceHandler("/images/custom-order/**")
                .addResourceLocations("file:" + basePath + "/custom-order/");
    }
}
