package group03.bloomresin.domain.dto;

import java.io.Serializable;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import jakarta.validation.constraints.AssertTrue;

public class RegisterDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    @Size(min = 3, message = "Họ phải có ít nhất 3 ký tự")
    private String firstName;

    @Size(min = 3, message = "Tên phải có ít nhất 3 ký tự")
    private String lastName;

    @Email(message = "Email không hợp lệ", regexp = "^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$")
    private String email;

    @Size(min = 6, message = "Mật khẩu phải có ít nhất 6 ký tự")
    private String password;

    private String confirmPassword;

    @Size(min = 10, message = "Số điện thoại phải có ít nhất 10 chữ số")
    private String phone;

    @NotNull(message = "Địa chỉ không được bỏ trống")
    private String address;

    @AssertTrue(message = "Mật khẩu và xác nhận mật khẩu phải trùng khớp")
    public boolean isPasswordMatching() {
        return password != null && password.equals(confirmPassword);
    }

    public String getFullName() {
        return firstName + " " + lastName;
    }

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getConfirmPassword() { return confirmPassword; }
    public void setConfirmPassword(String confirmPassword) { this.confirmPassword = confirmPassword; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
}
