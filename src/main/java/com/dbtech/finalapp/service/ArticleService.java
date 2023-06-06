package com.dbtech.finalapp.service;

import com.dbtech.finalapp.model.Article;
import com.dbtech.finalapp.model.Category;
import com.dbtech.finalapp.model.Comment;
import com.dbtech.finalapp.model.User;
import com.dbtech.finalapp.repository.ArticleRepository;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ArticleService {

    private final ArticleRepository articleRepository;

    @Autowired
    public ArticleService(ArticleRepository articleRepository) {
        this.articleRepository = articleRepository;
    }

    public void updateArticleFields(Article article) {
        Article articleToUpdate = articleRepository.findById(article.articleId).get();
        articleToUpdate.setDate(new Date());
        articleToUpdate.setText(article.getText());
        articleToUpdate.setName(article.getName());
        articleToUpdate.setCategory(article.getCategory());
        articleToUpdate.setImg_link(article.getImg_link());
        articleRepository.save(articleToUpdate);
    }

    public Article addComment(Article article, User user, String commentText) {
        if (article.getComments() == null) {
            article.setComments(new ArrayList<>());
        }
        article.getComments().add(Comment.builder()
                                         .comment_text(commentText)
                                         .author_id(user.getUserId())
                                         .author_first_name(user.getFirst_name())
                                         .author_last_name(user.getLast_name())
                                         .date(new Date())
                                         .build());
        return article;
    }

    public List<Article> fetchArticlesByUserId(ObjectId userId) {
        return articleRepository.findByAuthorId(userId);
    }

    public List<Article> fetchFourRelatedArticles(List<String> categories, Article article) {
        return articleRepository.findByCategoryIn(categories)
                                .stream()
                                .filter(obj -> !obj.getArticleId().equals(article.getArticleId()))
                                .sorted(Comparator.comparing(Article::getDate).reversed())
                                .limit(4)
                                .collect(Collectors.toList());
    }

    public boolean existsById(String articleId) {
        return articleRepository.existsById(new ObjectId(articleId));
    }

    public void deleteById(String articleId) {
        articleRepository.deleteById(new ObjectId(articleId));
    }
}
