package com.dbtech.finalapp.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;
import org.springframework.data.mongodb.core.mapping.MongoId;

import java.util.List;

@Getter
@Setter
@Builder
@Document(collection = "user")
@AllArgsConstructor
@RequiredArgsConstructor
public class User {
    @MongoId
    @Field("_id")
    private ObjectId userId;
    private String username;
    private String password;
    private List<Role> roles;
    private String first_name;
    private String last_name;
    private String about;
    private String city;
    private String img_link;
}


