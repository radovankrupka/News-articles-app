package com.dbtech.finalapp.controller;

import com.dbtech.finalapp.model.Article;
import com.dbtech.finalapp.repository.ArticleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class ArticleController {

    private final ArticleRepository articleRepository;

    @Autowired
    public ArticleController(ArticleRepository articleRepository) {
        this.articleRepository = articleRepository;
    }

    /*@GetMapping("/")
    public String showArticlesPage(Model model, @RequestParam(defaultValue = "1") int page) {
        int pageSize = 3;
        Pageable pageable = PageRequest.of(page, pageSize, Sort.by("date").descending());
        Page<Article> articlePage = articleRepository.findAll(pageable);
        List<Article> articles = articlePage.getContent();
        int totalPages = articlePage.getTotalPages();
        int currentPage = articlePage.getNumber();

        int startPage = Math.max(1, currentPage - 2);
        int endPage = Math.min(startPage + 4, totalPages);

        model.addAttribute("articles", articles);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);

        return "articles";
    }*/
    @GetMapping("/")
    public String showArticlesPage(Model model, @RequestParam(defaultValue = "0") int page) {
        int pageSize = 3;
        Pageable pageable = PageRequest.of(page, pageSize, Sort.by("date").descending());
        Page<Article> articlePage = articleRepository.findAll(pageable);
        List<Article> articles = articlePage.getContent();
        int totalPages = articlePage.getTotalPages();
        int currentPage = page + 1; // upravene

        // Vypočítajte novú hodnotu pre startPage a endPage
        int startPage = Math.max(1, currentPage - currentPage % 3);
        int endPage = Math.min(startPage + 2, totalPages);

        model.addAttribute("articles", articles);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);

        return "articles";
    }

}
