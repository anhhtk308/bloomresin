package group03.bloomresin.domain;

import jakarta.validation.constraints.NotEmpty;

public class PasswordChangeForm {

    @NotEmpty(message = "Vui lòng nhập mật khẩu hiện tại")
    private String currentPassword;

    @NotEmpty(message = "Vui lòng nhập mật khẩu mới")
    private String newPassword;

    @NotEmpty(message = "Vui lòng xác nhận lại mật khẩu mới")
    private String confirmPassword;

    public String getCurrentPassword() {
        return currentPassword;
    }

    public void setCurrentPassword(String currentPassword) {
        this.currentPassword = currentPassword;
    }

    public String getNewPassword() {
        return newPassword;
    }

    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }
}
