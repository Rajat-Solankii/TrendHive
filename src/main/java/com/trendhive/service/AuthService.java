package com.trendhive.service;

import com.trendhive.model.User;
import com.trendhive.repository.UserRepository;
import org.springframework.stereotype.Service;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.util.Optional;

@Service
public class AuthService {

    private final UserRepository userRepository;
    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    public AuthService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public Optional<User> login(String email, String password) {
        return userRepository.findByEmail(email)
                .filter(user -> passwordEncoder.matches(password, user.getPassword()));
    }

    public Optional<User> findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public User register(String name, String email, String password) {
        User user = new User();
        user.setName(name.trim());
        user.setEmail(email.trim().toLowerCase());
        // Persist a hash instead of the raw password.
        user.setPassword(passwordEncoder.encode(password));
        return userRepository.save(user);
    }

    public User updateProfile(User existingUser,
                              String name,
                              String phone,
                              String address,
                              String city,
                              String state,
                              String zipCode) {
        existingUser.setName(name.trim());
        existingUser.setPhone(phone.trim());
        existingUser.setAddress(address.trim());
        existingUser.setCity(city.trim());
        existingUser.setState(state.trim());
        existingUser.setZipCode(zipCode.trim());
        return userRepository.save(existingUser);
    }
}
