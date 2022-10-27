package com.AutoVision.servingwebcontent.repos;

import com.AutoVision.servingwebcontent.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserRepos extends JpaRepository<User, Long>{
    User findByUsername(String username);

    User findByActivationCode(String code);

    User findByEmail(String email);

    List<User> findByUsernameLike(String username);

    List<User> findByEmailLike(String email);

}
