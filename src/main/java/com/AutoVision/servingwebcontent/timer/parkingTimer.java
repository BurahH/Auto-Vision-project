package com.AutoVision.servingwebcontent.timer;

import com.AutoVision.servingwebcontent.domain.ParkingPlace;
import com.AutoVision.servingwebcontent.repos.ParkingPlaceRepos;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;

@Component
public class parkingTimer {
    @Autowired
    private ParkingPlaceRepos parkingPlaceRepos;

    @Scheduled(fixedDelay = 60000)
    public void checkDate(){
        Date date = new Date();
        List<ParkingPlace> parkingPlaces = parkingPlaceRepos.findByEndTimeLessThan(date);
        for(ParkingPlace parkingPlace : parkingPlaces){
            parkingPlace.setUser(null);
            parkingPlace.setEndTime(null);
            parkingPlace.setStatus("Открыт");
            parkingPlaceRepos.save(parkingPlace);
        }
    }
}
