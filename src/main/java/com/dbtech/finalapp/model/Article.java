package com.dbtech.finalapp.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.MongoId;

import java.util.Date;
import java.util.List;

@Getter
@Setter
@Builder
@AllArgsConstructor
@RequiredArgsConstructor()
@Document(collection = "article")
public class Article {
    @MongoId
    public ObjectId _id;
    public String id;
    public String name;
    public Date date;
    public String text;
    public ObjectId author_id;
    public String author_first_name;
    public String author_last_name;
    public List<String> category;
    public List<Comment> comments;

    public Article(String name, String text, String categoriesText) {
        this.name = name;
        this.text = text;
        this.category = null;
    }
}
