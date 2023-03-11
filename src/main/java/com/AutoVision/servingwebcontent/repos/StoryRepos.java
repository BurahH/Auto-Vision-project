package com.AutoVision.servingwebcontent.repos;

import com.AutoVision.servingwebcontent.domain.Story;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface StoryRepos extends CrudRepository<Story, Integer> {
    List<Story> findByCarId(Long userid);
}
