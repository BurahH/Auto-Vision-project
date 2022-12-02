package com.AutoVision.servingwebcontent.controller;

import com.AutoVision.servingwebcontent.domain.ParkingPlace;
import com.AutoVision.servingwebcontent.repos.CarRepos;
import com.AutoVision.servingwebcontent.repos.ParkingPlaceRepos;
import com.AutoVision.servingwebcontent.repos.StoryRepos;
import com.AutoVision.servingwebcontent.repos.UserRepos;
import com.AutoVision.servingwebcontent.service.ParkingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class parkingUserController {
    @Autowired
    private UserRepos userRepos;

    @Autowired
    private ParkingPlaceRepos parkingPlaceRepos;

    @Autowired
    private CarRepos carRepos;

    @Autowired
    private StoryRepos storyRepos;

    @Autowired
    private ParkingService parkingService;

    @GetMapping("/view")
    public String parking(Model model){
        Iterable<ParkingPlace> parkingPlace = parkingPlaceRepos.findAll();
        model.addAttribute("parking", parkingPlace);
        return "parkingUser";
    }

    @GetMapping("/view/{parking}")
    public String getParking(Model model, @PathVariable String parking){
        try {
            Long.parseLong(parking);
        } catch(NumberFormatException e){
            return "redirect:/view";
        }
        Long id = Long.parseLong (parking);
        ParkingPlace parkingPlace = parkingPlaceRepos.findByNumber(id);
        if(parkingPlace.getStatus().equals("Открыт")) {
            model.addAttribute("parking", parkingPlace);
            return "parkingView";
        }
        else{
            return "redirect:/view";
        }
    }

    @PostMapping("/view/{parking}")
    public String buyParking(Model model, @PathVariable String parking){
        try {
            Long.parseLong(parking);
        } catch(NumberFormatException e){
            return "redirect:/view";
        }
        Long id = Long.parseLong (parking);
        ParkingPlace parkingPlace = parkingPlaceRepos.findByNumber(id);
        if(parkingPlace.getStatus().equals("Открыт")) {
            model.addAttribute("parking", parkingPlace);
            return "parkingView";
        }
        else{
            return "redirect:/view";
        }
    }
}
