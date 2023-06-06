package com.dbtech.finalapp.controller;

import com.dbtech.finalapp.model.Article;
import com.dbtech.finalapp.model.Comment;
import com.dbtech.finalapp.model.User;
import com.dbtech.finalapp.repository.ArticleRepository;
import com.dbtech.finalapp.repository.UserRepository;
import com.dbtech.finalapp.service.ArticleService;
import com.dbtech.finalapp.service.CategoryService;
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

import javax.servlet.http.HttpServletRequest;

@Controller
public class ArticleController {

    private final ArticleRepository articleRepository;
    private final UserRepository userRepository;
    private final CategoryService categoryService;
    private final ArticleService articleService;
    @Autowired
    public ArticleController(ArticleRepository articleRepository, UserRepository userRepository, CategoryService categoryService,
                             ArticleService articleService) {
        this.articleRepository = articleRepository;
        this.userRepository = userRepository;
        this.categoryService = categoryService;
        this.articleService = articleService;
    }

    @GetMapping("/")
    public String showArticlesPage(Model model, @RequestParam(defaultValue = "0") int page, Authentication authentication) {
        int pageSize = 3;
        Pageable pageable = PageRequest.of(page, pageSize, Sort.by("date").descending());
        Page<Article> articlePage = articleRepository.findAll(pageable);
        List<Article> articles = articlePage.getContent();
        int totalPages = articlePage.getTotalPages();
        int currentPage = page + 1; // upravene

        // Vypočíta novú hodnotu pre startPage a endPage
        int startPage = Math.max(1, currentPage - currentPage % 3);
        int endPage = Math.min(startPage + 2, totalPages);

        model.addAttribute("articles", articles);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);

        if (authentication != null && authentication.isAuthenticated()) {
            model.addAttribute("currentUser", userRepository.findByUsername(authentication.getName()));
        }

        return "articles";
    }

    // show article form, to add new article
    @GetMapping("/article/new")
    public String showArticleForm(Model model) {
        model.addAttribute("article", Article.builder().articleId(new ObjectId()).build());
        model.addAttribute("categories", categoryService.fetchAllUsedCategories());
        return "article-form";
    }

    //update existing or insert new article
    @PostMapping("/article")
    public String addArticle(@ModelAttribute("article") Article article, Principal principal) {
        User user = userRepository.findByUsername(principal.getName());
        Article articleToSave;
        if ( articleRepository.existsById(article.articleId)){ // update article
            articleService.updateArticleFields(article);
        } else {    //add new article
            articleToSave = Article.builder()
                                       .articleId(new ObjectId())
                                       .date(new Date())
                                       .category(article.getCategory())
                                       .name(article.getName())
                                       .text(article.getText())
                                       .author_id(user.getUserId())
                                       .author_first_name(user.getFirst_name())
                                       .author_last_name(user.getLast_name())
                                       .img_link(article.getImg_link())
                                   .build();
            articleRepository.save(articleToSave);
            return "redirect:/article/"+articleToSave.articleId;
        }
        return "redirect:/article/"+article.articleId;
    }

    // show article-form to edit, prefilled with data
    @GetMapping("/article/edit/{id}")
    public String showEditArticleForm(@PathVariable("id") String id, Model model) {
        ObjectId objectId;
        try {
            objectId = new ObjectId(id);
        } catch (IllegalArgumentException e) {
            return "redirect:/articles";
        }

        model.addAttribute("categories", categoryService.fetchAllUsedCategories());

        Optional<Article> articleOptional = articleRepository.findById(objectId);
        if (articleOptional.isPresent()) {
            Article article = articleOptional.get();
            model.addAttribute("article", article);
            return "article-form";
        } else {
            return "redirect:/articles";
        }
    }

    //show article detail
    @GetMapping("/article/{id}")
    public String showArticleDetail(@PathVariable("id") String id, Model model, Authentication authentication) {
        Optional<Article> articleOptional = articleRepository.findById(new ObjectId(id));
        if (authentication != null && authentication.isAuthenticated()) {
            model.addAttribute("currentUser", userRepository.findByUsername(authentication.getName()));
        }
        if (articleOptional.isPresent()) {
            Article article = articleOptional.get();
            model.addAttribute("article", article);

            //get 4 related articles by categories
            model.addAttribute("relatedArticles",articleService.fetchFourRelatedArticles(article.getCategory(), article));

            return "article-detail";
        } else {
            return "redirect:/error";
        }
    }

    //delete article by ID
    @GetMapping("/article/delete/{articleId}")
    public String deleteArticle(@PathVariable String articleId, HttpServletRequest request) {
        if (articleService.existsById(articleId)){
            articleService.deleteById(articleId);
            String referer = request.getHeader("Referer");
            if (referer != null) {
                return "redirect:" + referer;
            } else {
                return "redirect:/";
            }
        }
        return "/error";
    }

    // post new comment for a given article
    @PostMapping("/article/comment")
    public String addComment(@RequestParam("commentText") String commentText,
                             @RequestParam("articleId") String articleId,
                             Principal principal) {
        Optional<Article> articleOptional = articleRepository.findById(new ObjectId(articleId));
        User user = userRepository.findByUsername(principal.getName());
        if (articleOptional.isPresent()) {
            Article article = articleOptional.get();

            article = articleService.addComment(article,user, commentText);

            articleRepository.save(article);
        } else {
            return "redirect:/error";
        }
        return "redirect:/article/" + articleId;
    }
}
