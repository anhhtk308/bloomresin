package group03.bloomresin.controller.admin;

import group03.bloomresin.domain.Contact;
import group03.bloomresin.service.ContactService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ADContactController {

    @Autowired
    private ContactService contactService;

    @GetMapping("/admin/contact")
    public String showContactList(Model model) {
        model.addAttribute("contactList", contactService.getAllContacts());
        return "admin/contact/show";
    }

    @GetMapping("/admin/contact/view/{id}")
    public String viewContactDetail(@PathVariable("id") Long id, Model model) {
        Contact contact = contactService.getContactById(id);
        if (contact == null) {
            model.addAttribute("errorMessage", "Liên hệ không tồn tại.");
            return "admin/contact/show";
        }

        model.addAttribute("contact", contact);
        return "admin/contact/view";
    }

    @GetMapping("/admin/contact/confirm-delete/{id}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String confirmDeleteContact(@PathVariable("id") Long id, Model model) {
        Contact contact = contactService.getContactById(id);

        if (contact == null) {
            model.addAttribute("errorMessage", "Liên hệ không tồn tại.");
            return "redirect:/admin/contact";
        }

        model.addAttribute("contact", contact);
        return "admin/contact/delete";
    }

    @GetMapping("/admin/contact/delete/{id}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String deleteContact(@PathVariable("id") Long id, Model model) {
        boolean isDeleted = contactService.deleteContact(id);

        if (!isDeleted) {
            model.addAttribute("errorMessage", "Lỗi: Không thể xóa liên hệ.");
        } else {
            model.addAttribute("successMessage", "Xóa liên hệ thành công.");
        }

        return "redirect:/admin/contact";
    }
}