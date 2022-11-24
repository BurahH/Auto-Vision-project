package com.AutoVision.servingwebcontent.repos;

import com.AutoVision.servingwebcontent.domain.Car;
import org.springframework.data.repository.CrudRepository;

import java.util.List;
import java.util.Set;

public interface CarRepos extends CrudRepository<Car, Integer>{
    List<Car> findByUserId(Long userid);
    Car findByNumber(String number);
}
