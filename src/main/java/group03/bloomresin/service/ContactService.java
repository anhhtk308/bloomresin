package group03.bloomresin.service;

import group03.bloomresin.domain.Contact;
import group03.bloomresin.repository.ContactRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

import java.util.List;

@Service
public class ContactService {
    @Autowired
    private ContactRepository contactRepository;
    public List<Contact> getAllContacts() {
        return contactRepository.findAll();
    }
    public Contact getContactById(Long id) {
        Optional<Contact> contact = contactRepository.findById(id);
        return contact.orElse(null);
    }

    public boolean deleteContact(Long id) {
        if (contactRepository.existsById(id)) {
            contactRepository.deleteById(id);
            return true;
        }
        return false;
    }

    public void saveContact(Contact contact) {
        contact.setStatus(true);
        contactRepository.save(contact);
    }
}
