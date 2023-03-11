package com.AutoVision.servingwebcontent.repos;

import com.AutoVision.servingwebcontent.domain.Car;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CarRepos extends JpaRepository<Car, Long> {
    List<Car> findByUserId(Long userid);
    Car findByNumber(String number);
    Car findByVin(String vin);
    List<Car> findByModelLike(String model);
    List<Car> findByNumberLike(String model);
    List<Car> findByInParking(boolean b);
}
