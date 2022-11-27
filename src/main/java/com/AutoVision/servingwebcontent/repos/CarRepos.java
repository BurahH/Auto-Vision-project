package com.AutoVision.servingwebcontent.repos;

import com.AutoVision.servingwebcontent.domain.Car;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;

import java.util.List;
import java.util.Set;

public interface CarRepos extends JpaRepository<Car, Integer> {
    List<Car> findByUserId(Long userid);
    Car findByNumber(String number);
    Car findByVin(String vin);
    Car findById(Long id);
    List<Car> findByModelLike(String model);
    List<Car> findByNumberLike(String model);
    void  deleteById(Long id);
}
