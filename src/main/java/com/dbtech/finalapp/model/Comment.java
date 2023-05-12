package com.dbtech.finalapp.model;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.core.mapping.MongoId;

import java.util.Date;

@Getter
@Setter
@Builder
public class Comment {
    private String comment_id;
    private Date date;
    private String comment_text;
    private ObjectId author_id;
    private String author_first_name;
    private String author_last_name;

}
