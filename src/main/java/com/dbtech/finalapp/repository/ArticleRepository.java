package com.dbtech.finalapp.repository;

import com.dbtech.finalapp.model.Article;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface ArticleRepository extends MongoRepository<Article, ObjectId> {
}

