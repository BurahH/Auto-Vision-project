package com.AutoVision.servingwebcontent.repos;

import com.AutoVision.servingwebcontent.domain.Car;
import com.AutoVision.servingwebcontent.domain.ParkingPlace;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ParkingPlaceRepos extends CrudRepository<ParkingPlace, Integer> {
    List<ParkingPlace> findByUserId(Long userid);
}
