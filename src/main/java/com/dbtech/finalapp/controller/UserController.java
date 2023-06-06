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

import javax.servlet.http.HttpServletRequest;

@Controller
public class UserController {

    private final UserService userService;
    private final UserRepository userRepository;

    @Autowired
    public UserController(UserService userService, UserRepository userRepository) {
        this.userService = userService;
        this.userRepository = userRepository;
    }

    @GetMapping("/user/{userId}")
    public String userProfile(@PathVariable String userId,Model model, Principal principal) {
        String username = principal.getName();
        User user = userService.findById(userId).orElse(new User());
        model.addAttribute("currentUser", user);
        model.addAttribute("articles", userService.fetchFourLatestArticles(user.getUserId()) );
        return "user-detail";
    }

    @GetMapping("/user/edit/{userId}")
    public String editProfile(@PathVariable String userId, Model model, Principal principal, HttpServletRequest request) {
        Optional<User> userOptional = userService.findById(userId);
        if (userOptional.isPresent()){
            model.addAttribute("currentUser", userOptional.get());
            return "user-form";
        }
        return "/error";
    }

    @PostMapping("/user/edit/{userId}")
    public String saveProfileChanges(@PathVariable String userId, @ModelAttribute User user, Model model){
        if (userService.findById(userId).isPresent()){
            userService.saveProfileUpdates(userId, user);
            return "redirect:/";
        }
        return "/error";
    }
    
    @GetMapping("/user/delete/{userId}")
    public String deleteUser(@PathVariable String userId, Model model, HttpServletRequest request){
        if (userService.findById(userId).isPresent()){
            userService.deleteById(userId);
            String referer = request.getHeader("Referer");
            if (referer != null) {
                return "redirect:" + referer;
            } else {
                return "redirect:/";
            }
        }
        return "/error";
    }

}