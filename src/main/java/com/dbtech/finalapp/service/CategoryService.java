package com.dbtech.finalapp.service;

import com.dbtech.finalapp.model.Category;
import com.dbtech.finalapp.repository.ArticleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class CategoryService {
    private final ArticleRepository articleRepository;

    @Autowired
    public CategoryService(ArticleRepository articleRepository) {
        this.articleRepository = articleRepository;
    }
    public List<String> fetchAllUsedCategories() {
     return articleRepository.findAllDistinctCategories()
                                                   .stream()
                                                   .map(Category::getCategory)
                                                   .flatMap(Collection::stream)
                                                   .distinct()
                                                   .collect(Collectors.toList());
    }
}
