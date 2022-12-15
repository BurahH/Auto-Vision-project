package com.AutoVision.servingwebcontent.service;

import com.AutoVision.servingwebcontent.domain.ParkingPlace;
import com.AutoVision.servingwebcontent.repos.CarRepos;
import com.AutoVision.servingwebcontent.repos.ParkingPlaceRepos;
import com.AutoVision.servingwebcontent.repos.StoryRepos;
import com.AutoVision.servingwebcontent.repos.UserRepos;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ParkingService {

    @Autowired
    private ParkingPlaceRepos parkingPlaceRepos;

    public void addNewParking(Long id){
        ParkingPlace newParkingPlace = new ParkingPlace();
        newParkingPlace.setNumber(id);
        newParkingPlace.setStatus("Открыт");
        parkingPlaceRepos.save(newParkingPlace);
    }
}
