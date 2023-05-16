package com.dbtech.finalapp.repository;

import com.dbtech.finalapp.model.Article;
import com.dbtech.finalapp.model.Category;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

import java.util.Date;
import java.util.List;

public interface ArticleRepository extends MongoRepository<Article, ObjectId> {
    @Query(value = "{}", fields = "{ 'category' : 1}")
    List<Category> findAllDistinctCategories();

    @Query("{'author_id': ?0}")
    List<Article> findByAuthorId(ObjectId authorId);

    List<Article> findByCategoryIn(List<String> categories);
}

