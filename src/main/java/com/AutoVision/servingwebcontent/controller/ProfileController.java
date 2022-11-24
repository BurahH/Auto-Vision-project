package com.AutoVision.servingwebcontent.controller;

import com.AutoVision.servingwebcontent.domain.Car;
import com.AutoVision.servingwebcontent.domain.User;
import com.AutoVision.servingwebcontent.repos.CarRepos;
import com.AutoVision.servingwebcontent.repos.UserRepos;
import com.AutoVision.servingwebcontent.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Set;

@Controller
public class ProfileController {
    @Autowired
    private UserRepos userRepos;

    @Autowired
    private UserService userService;

    @GetMapping("profile")
    public String getProfile(Model model, @AuthenticationPrincipal User user){
        model.addAttribute("user", user);

        List<Car> cars = userService.findUserCar(user.getId());
        model.addAttribute("car", cars);

        return "profile";
    }

    @PostMapping("profile")
    public String newCar(Model model, @AuthenticationPrincipal User user,
                         @RequestParam String modelCar,
                         @RequestParam String number){
        String message = userService.addCar(modelCar, number, user);
        if(message == "Not save"){
            model.addAttribute("message", "Автомобиль с таким номер уже существует");
        }
        model.addAttribute("user", user);

        List<Car> cars = userService.findUserCar(user.getId());
        model.addAttribute("car", cars);

        return "profile";
    }

    @GetMapping("profile/security")
    public String getProfileSecurity(Model model, @AuthenticationPrincipal User user){
        model.addAttribute("user", user);

        model.addAttribute("username", user.getUsername());
        model.addAttribute("email", user.getEmail());
        model.addAttribute("message", null);

        return "profileSecurity";
    }

    @PostMapping("profile/security")
    public String updateProfileSecurity(Model model,
                                        @AuthenticationPrincipal User user,
                                        @RequestParam String password,
                                        @RequestParam String email
    ){
        userService.updateProfile(user, password, email);
        String message = "aaaa";
        model.addAttribute("username", user.getUsername());
        model.addAttribute("email", user.getEmail());
        model.addAttribute("message", message);

        return "profileSecurity";
    }
}
