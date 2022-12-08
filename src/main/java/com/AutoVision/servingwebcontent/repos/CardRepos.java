package com.AutoVision.servingwebcontent.repos;

import com.AutoVision.servingwebcontent.domain.Car;
import com.AutoVision.servingwebcontent.domain.Card;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CardRepos extends JpaRepository<Card, Long> {
    Card findByNumber(String number);
}
