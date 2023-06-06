package com.dbtech.finalapp.controller;

import com.dbtech.finalapp.model.Article;
import com.dbtech.finalapp.model.User;
import com.dbtech.finalapp.repository.ArticleRepository;
import com.dbtech.finalapp.repository.UserRepository;
import com.dbtech.finalapp.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class AdminController {


    private final ArticleRepository articleRepository;
    private final UserRepository userRepository;
    private final ArticleService articleService;

    @Autowired
    public AdminController(ArticleRepository articleRepository, UserRepository userRepository, ArticleService articleService) {
        this.articleRepository = articleRepository;
        this.userRepository = userRepository;
        this.articleService = articleService;
    }

    @GetMapping("/admin")
    public String showAdminPanel(Model model,
                                 @RequestParam(name = "display", defaultValue = "articles") String display,
                                 @RequestParam(name = "page", defaultValue = "1") int page) {
        int recordsPerPage = 10;
        int currentPage = page;
        int startIndex = page * recordsPerPage - recordsPerPage;
        int totalRecords, totalPages, endIndex;

        List<Article> articles = articleRepository.findAll();
        List<User> users = userRepository.findAll();

        if ("articles".equals(display)) {
            totalRecords = articles.size();
            totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
            endIndex = Math.min(startIndex + recordsPerPage, totalRecords);

            List<Article> articlesForPage = articles.subList(startIndex, endIndex);
            model.addAttribute("articles", articlesForPage);
            model.addAttribute("totalPages", totalPages);
        }

        if ("users".equals(display)){
            totalRecords = users.size();
            totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
            endIndex = Math.min(startIndex + recordsPerPage, totalRecords);

            List<User> usersForPage = users.subList(startIndex, endIndex);
            model.addAttribute("users", usersForPage);
            model.addAttribute("totalPages", totalPages);
        }

        model.addAttribute("display", display);
        model.addAttribute("currentPage", currentPage);

        return "admin-panel";
    }


}
