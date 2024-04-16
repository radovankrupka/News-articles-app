package com.dbtech.finalapp.controller;

import com.dbtech.finalapp.model.UserDTO;
import com.dbtech.finalapp.repository.UserRepository;
import com.dbtech.finalapp.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

@Controller
public class MainController {

    private final UserService userService;
    private final UserRepository userRepository;

    @Autowired
    public MainController(UserService userService, UserRepository userRepository) {
        this.userService = userService;
        this.userRepository = userRepository;
    }

    @GetMapping("/login")
    public String login(@RequestParam(name = "error", required = false) String error, Model model) {
        if ( error != null && error.isEmpty()){
            model.addAttribute("error", "Invalid credentials!");
        }
        try {
            Thread.sleep(250);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
        return "login";
    }

    @GetMapping("/register")
    public String showRegisterForm( Model model) {
        UserDTO userDto = new UserDTO();
        model.addAttribute("user", userDto);
        return "register";
    }

    @PostMapping("/register")
    public String registerNewAcc(@ModelAttribute("user") @Validated UserDTO userDTO, BindingResult result, Model model){
        List<ObjectError> errors = new ArrayList<>();
        if (result.hasErrors() ) {
            errors = result.getAllErrors();
            model.addAttribute("errors", errors);
            return "register";
        }
        if (userRepository.findByUsername(userDTO.getUsername()) != null) {
            errors.add(new ObjectError("username","User with this username/email already exists!"));
            model.addAttribute("errors", errors);
            return "register";
        }
        userService.saveNewUser(userDTO);
        model.addAttribute("message", "Registration succesful! Proceed with login.");
        return "login";
    }
}
