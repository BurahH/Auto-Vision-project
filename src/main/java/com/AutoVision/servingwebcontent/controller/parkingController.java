package com.AutoVision.servingwebcontent.controller;

import com.AutoVision.servingwebcontent.domain.ParkingPlace;
import com.AutoVision.servingwebcontent.domain.User;
import com.AutoVision.servingwebcontent.repos.CarRepos;
import com.AutoVision.servingwebcontent.repos.ParkingPlaceRepos;
import com.AutoVision.servingwebcontent.repos.StoryRepos;
import com.AutoVision.servingwebcontent.repos.UserRepos;
import com.AutoVision.servingwebcontent.service.ParkingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/parking")
public class parkingController {
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

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping
    public String getParking(Model model){
        Iterable<ParkingPlace> parkingPlace = parkingPlaceRepos.findAll();
        model.addAttribute("parking", parkingPlace);
        return "parking";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("{parking}")
    public String getEditParking(Model model, @PathVariable String parking){
        try {
            Long.parseLong(parking);
        } catch(NumberFormatException e){
            return "redirect:/parking";
        }
        Long id = Long.parseLong (parking);
        ParkingPlace parkingPlace = parkingPlaceRepos.findByNumber(id);
        if(parkingPlaceRepos.findByNumber(id) == null)
        {
            parkingService.addNewParking(id);
            ParkingPlace newParkingPlace = parkingPlaceRepos.findByNumber(id);
            model.addAttribute("parking", newParkingPlace);
            return "parkingEdit";
        }
        model.addAttribute("parking", parkingPlace);
        return "parkingEdit";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping
    public String editParking(Model model,
                              @RequestParam int price,
                              @RequestParam int priceBuy,
                              @RequestParam Long parkingId){
        ParkingPlace parkingPlace = parkingPlaceRepos.getOne(parkingId);
        if((parkingPlace.getPriceBuy() == priceBuy) && (parkingPlace.getPrice() == price))
        {
            model.addAttribute("classInscription", "alert alert-danger");
            model.addAttribute("message", "Не введено новых данных");
            model.addAttribute("parking", parkingPlace);
            return "parkingEdit";
        }
        parkingPlace.setPriceBuy(priceBuy);
        parkingPlace.setPrice(price);
        parkingPlaceRepos.save(parkingPlace);
        model.addAttribute("classInscription", "alert alert-success");
        model.addAttribute("message", "Пользователь успешно изменен");
        model.addAttribute("parking", parkingPlace);
        return "parkingEdit";
    }
}
