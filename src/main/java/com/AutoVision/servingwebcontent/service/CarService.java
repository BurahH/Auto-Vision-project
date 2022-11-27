package com.AutoVision.servingwebcontent.service;

import com.AutoVision.servingwebcontent.domain.Car;
import com.AutoVision.servingwebcontent.repos.CarRepos;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CarService {

    @Autowired
    private CarRepos carRepos;

    @Value("${upload.path}")
    private String uploadPath;

    public Object findCar(String filter) {
        List<Car> findCar = carRepos.findByModelLike(filter + '%');
        findCar.addAll(carRepos.findByNumberLike(filter + '%'));
        return findCar;
    }


    public List<Car> findAllCar() {
        return carRepos.findAll();
    }
}
