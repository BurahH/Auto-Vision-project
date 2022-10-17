package com.AutoVision.servingwebcontent.repos;

import com.AutoVision.servingwebcontent.domain.Message;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface MessageRepos extends CrudRepository<Message, Integer> {

    List<Message> findByText(String text);
}
