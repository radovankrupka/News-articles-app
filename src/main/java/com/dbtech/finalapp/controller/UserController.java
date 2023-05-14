package com.dbtech.finalapp.controller;

import com.dbtech.finalapp.model.User;
import com.dbtech.finalapp.repository.UserRepository;
import com.dbtech.finalapp.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.security.Principal;
import java.util.Optional;

@Controller
public class UserController {

    private final UserService userService;
    private final UserRepository userRepository;

    @Autowired
    public UserController(UserService userService, UserRepository userRepository) {
        this.userService = userService;
        this.userRepository = userRepository;
    }

    @GetMapping("/user")
    public String userProfile(Model model, Principal principal) {
        String username = principal.getName();
        User user = userRepository.findByUsername(username);
        model.addAttribute("currentUser", user);
        model.addAttribute("articles", userService.fetchFourLatestArticles(user.getUserId()) );
        return "user-detail";
    }

    @GetMapping("/user/edit/{userId}")
    public String editProfile(@PathVariable String userId, Model model, Principal principal) {
        // Načítajte údaje profilu z databázy na základe prihlasovacích údajov
        Optional<User> userOptional = userRepository.findById(userId);
        if (userOptional.isPresent()){
            model.addAttribute("currentUser", userOptional.get());
            return "user-form";
        }
        return "/error";
    }

    @PostMapping("/user/edit/{userId}")
    public String saveProfileChanges(@PathVariable String userId, @ModelAttribute User user, Model model){
        if (userRepository.existsById(userId)){
            userService.saveProfileUpdates(userId, user);
            return "redirect:/user";
        }
        return "/error";
    }

}