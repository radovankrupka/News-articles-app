package com.dbtech.finalapp.model;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.MongoId;

import java.util.List;

@Getter
@Setter
@Builder
@Document(collection = "user")
public class User {
    @MongoId
    private ObjectId _id;
    private String username;
    private String password;
    private List<Role> roles;
    private String first_name;
    private String last_name;
}


