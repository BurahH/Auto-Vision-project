package com.example.servingwebcontent.repos;

import com.example.servingwebcontent.domain.Message;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface MessageRepos extends CrudRepository<Message, Integer> {

    List<Message> findByText(String text);
}
