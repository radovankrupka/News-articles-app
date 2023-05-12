package com.dbtech.finalapp.model;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.MongoId;

import java.util.List;

@Document(collection = "article")
public class Article {
    @MongoId
    private ObjectId objectId;
    private String name;
    private String date;
    private String text;
    private String author;
    private List<Comment> comment;
    private List<String> category;

    public Article() {
    }

    public Article(ObjectId objectId, String name, String date, String text, String author, List<Comment> comment, List<String> category) {
        this.objectId = objectId;
        this.name = name;
        this.date = date;
        this.text = text;
        this.author = author;
        this.comment = comment;
        this.category = category;
    }

    public ObjectId getObjectId() {
        return objectId;
    }

    public void setObjectId(ObjectId objectId) {
        this.objectId = objectId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public List<Comment> getComment() {
        return comment;
    }

    public void setComment(List<Comment> comment) {
        this.comment = comment;
    }

    public List<String> getCategory() {
        return category;
    }

    public void setCategory(List<String> category) {
        this.category = category;
    }
}
