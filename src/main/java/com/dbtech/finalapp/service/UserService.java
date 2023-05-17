package com.dbtech.finalapp.service;

import static com.dbtech.finalapp.model.Role.USER;

import com.dbtech.finalapp.model.Article;
import com.dbtech.finalapp.model.User;
import com.dbtech.finalapp.model.UserDTO;
import com.dbtech.finalapp.repository.UserRepository;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class UserService {
    private final PasswordEncoder passwordEncoder;
    private final ArticleService articleService;
    private final UserRepository userRepository;
    @Autowired
    public UserService(PasswordEncoder passwordEncoder, ArticleService articleService, UserRepository userRepository) {
        this.passwordEncoder = passwordEncoder;
        this.articleService = articleService;
        this.userRepository = userRepository;
    }

    public List<Article> fetchFourLatestArticles(ObjectId userId){
        List<Article> recentArticles = articleService.fetchArticlesByUserId(userId);
        return recentArticles.stream()
                             .sorted(Comparator.comparing(Article::getDate).reversed())
                             .limit(4)
                             .collect(Collectors.toList());
    }

    public void saveProfileUpdates(String userId, User user) {
        User userToUpdate = userRepository.findById(userId).get();
        userToUpdate.setAbout(user.getAbout());
        userToUpdate.setCity(user.getCity());
        userToUpdate.setFirst_name(user.getFirst_name());
        userToUpdate.setLast_name(user.getLast_name());
        userRepository.save(userToUpdate);
    }

    public void saveNewUser(UserDTO userDTO) {
        User user = User.builder()
                            .first_name(userDTO.getFirstName())
                            .last_name(userDTO.getLastName())
                            .username(userDTO.getUsername())
                            .roles(Collections.singletonList(USER))
                            .city("Upper Lower city")
                            .about("I have not yet added my info! Time for a change?")
                            .password(passwordEncoder.encode(userDTO.getPassword()))
                        .build();
        userRepository.save(user);
    }
}
