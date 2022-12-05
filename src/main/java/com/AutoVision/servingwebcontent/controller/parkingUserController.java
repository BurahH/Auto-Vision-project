package com.AutoVision.servingwebcontent.controller;

import com.AutoVision.servingwebcontent.domain.ParkingPlace;
import com.AutoVision.servingwebcontent.domain.User;
import com.AutoVision.servingwebcontent.repos.CarRepos;
import com.AutoVision.servingwebcontent.repos.ParkingPlaceRepos;
import com.AutoVision.servingwebcontent.repos.StoryRepos;
import com.AutoVision.servingwebcontent.repos.UserRepos;
import com.AutoVision.servingwebcontent.service.ParkingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

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

    @PostMapping("/view")
    public String buyParking(Model model,
                             @AuthenticationPrincipal User user,
                             @RequestParam(required = false) int priceBuy,
                             @RequestParam Long parkingPlaceId){
        //if(user.getActivationCode() != null){
        //    model.addAttribute("message", "Пожалуйста подтвердите почту для покупки места")
       // }
        ParkingPlace parkingPlace = parkingPlaceRepos.getOne(parkingPlaceId);
        if(parkingPlace.getStatus().equals("Открыт")) {
            if(priceBuy == 0)
            {
                parkingPlace.setStatus("Куплен");
                parkingPlace.setUser(user);
            }
            else{
                parkingPlace.setStatus("Арендован");
                Calendar calendar = new GregorianCalendar();
                calendar.add(Calendar.MONTH, priceBuy);
                Date date = calendar.getTime();
                parkingPlace.setEndTime(date);
                parkingPlace.setUser(user);
            }
            parkingPlaceRepos.save(parkingPlace);
            model.addAttribute("parking", parkingPlace);
            return "redirect:/";
        }
        else{
            return "redirect:/view";
        }
    }
}
