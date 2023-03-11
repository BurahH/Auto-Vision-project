package com.AutoVision.servingwebcontent.repos;

import com.AutoVision.servingwebcontent.domain.ParkingPlace;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Date;
import java.util.List;

public interface ParkingPlaceRepos extends JpaRepository<ParkingPlace, Long> {
    List<ParkingPlace> findByUserId(Long userid);
    ParkingPlace findByNumber(Long number);
    List<ParkingPlace> findByEndTimeLessThan(Date date);
}
