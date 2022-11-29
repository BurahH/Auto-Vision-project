package com.AutoVision.servingwebcontent.repos;

import com.AutoVision.servingwebcontent.domain.ParkingPlace;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface ParkingPlaceRepos extends JpaRepository<ParkingPlace, Long> {
    List<ParkingPlace> findByUserId(Long userid);
    ParkingPlace findByNumber(Long number);
}
