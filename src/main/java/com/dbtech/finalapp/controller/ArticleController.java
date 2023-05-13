package com.dbtech.finalapp.controller;

import com.dbtech.finalapp.model.Article;
import com.dbtech.finalapp.model.Comment;
import com.dbtech.finalapp.model.User;
import com.dbtech.finalapp.repository.ArticleRepository;
import com.dbtech.finalapp.repository.UserRepository;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Controller
public class ArticleController {

    private final ArticleRepository articleRepository;
    private final UserRepository userRepository;

    @Autowired
    public ArticleController(ArticleRepository articleRepository, UserRepository userRepository) {
        this.articleRepository = articleRepository;
        this.userRepository = userRepository;
    }

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

    @GetMapping("/article/new")
    public String showArticleForm(Model model) {
        model.addAttribute("article", Article.builder().build());
        return "article-form";
    }

    @PostMapping("/article/new")
    public String addArticle(@ModelAttribute("article") Article article) {
        articleRepository.save(article);
        return "redirect:/article/" + article.get_id();
    }

    // Metóda pre zobrazenie formulára pre úpravu článku
    @GetMapping("/article/edit/{id}")
    public String showEditArticleForm(@PathVariable("id") String id, Model model) {
        ObjectId objectId;
        try {
            objectId = new ObjectId(id);
        } catch (IllegalArgumentException e) {
            return "redirect:/articles";
        }
        Optional<Article> articleOptional = articleRepository.findById(objectId);
        if (articleOptional.isPresent()) {
            Article article = articleOptional.get();
            model.addAttribute("article", article);
            return "article-form";
        } else {
            return "redirect:/articles";
        }
    }

    // Metóda pre spracovanie úpravy článku
    @PostMapping("/article/edit")
    public String editArticle(@ModelAttribute("article") Article article) {
        articleRepository.save(article);
        return "redirect:/articles";
    }
    @GetMapping("/article/{id}")
    public String showArticleDetail(@PathVariable("id") String id, Model model, Authentication authentication) {
        Optional<Article> articleOptional = articleRepository.findById(new ObjectId(id));
        //TODO: add list of related articles based on common categories
        if (authentication != null && authentication.isAuthenticated()) {
            model.addAttribute("currentUser", userRepository.findByUsername(authentication.getName()));
        }
        if (articleOptional.isPresent()) {
            Article article = articleOptional.get();
            model.addAttribute("article", article);
            return "article-detail";
        } else {
            return "redirect:/error";
        }
    }

    @PostMapping("/article/comment")
    public String addComment(@RequestParam("commentText") String commentText,
                             @RequestParam("articleId") String articleId,
                             Principal principal) {
        Optional<Article> articleOptional = articleRepository.findById(new ObjectId(articleId));
        User user = userRepository.findByUsername(principal.getName());
        if (articleOptional.isPresent()) {
            Article article = articleOptional.get();

            article.getComments().add(Comment.builder()
                                             .comment_text(commentText)
                                             .author_id(user.get_id())
                                             .author_first_name(user.getFirst_name())
                                             .author_last_name(user.getLast_name())
                                             .date(new Date())
                                             .build());

            articleRepository.save(article);
        } else {
            return "redirect:/error";
        }
        return "redirect:/article/" + articleId;
    }

}
