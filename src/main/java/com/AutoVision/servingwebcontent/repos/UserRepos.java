package com.AutoVision.servingwebcontent.repos;

import com.AutoVision.servingwebcontent.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepos extends JpaRepository<User, Long>{
    User findByUsername(String username);
}
