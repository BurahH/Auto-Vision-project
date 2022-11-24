package com.AutoVision.servingwebcontent.controller;

import com.AutoVision.servingwebcontent.domain.Car;
import com.AutoVision.servingwebcontent.domain.User;
import com.AutoVision.servingwebcontent.repos.CarRepos;
import com.AutoVision.servingwebcontent.repos.UserRepos;
import com.AutoVision.servingwebcontent.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Set;
import java.util.UUID;

@Controller
public class ProfileController {
    @Autowired
    private UserRepos userRepos;

    @Autowired
    private UserService userService;

    @Value("${upload.path}")
    private String uploadPath;

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

    @GetMapping("/profile/edit")
    public String getEditProfile(Model model, @AuthenticationPrincipal User user){
        model.addAttribute("user", user);

        return "profileRedact";
    }
    @PostMapping("/profile/edit")
    public String editProfile(@AuthenticationPrincipal User user,
                             @RequestParam String name,
                             @RequestParam String number,
                             Model model,
                             MultipartFile photo,
                            MultipartFile osago) throws IOException {
        if(!photo.isEmpty()) {
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            String uuidFile = UUID.randomUUID().toString();
            String resultFilename = uuidFile + "." + photo.getOriginalFilename();
            photo.transferTo(new File(uploadPath + "/" + resultFilename));
            user.setPhoto(resultFilename);
        }
        if(!osago.isEmpty()) {
            File uploadDir2 = new File(uploadPath);
            if (!uploadDir2.exists()) {
                uploadDir2.mkdir();
            }
            String uuidFile2 = UUID.randomUUID().toString();
            String resultFilename2 = uuidFile2 + "." + osago.getOriginalFilename();
            osago.transferTo(new File(uploadPath + "/" + resultFilename2));
            user.setPhotoOsago(resultFilename2);
        }

        user.setName(name);
        user.setNumber(number);

        userRepos.save(user);  //TODO сброс роли full_user

        model.addAttribute("user", user);

        return "profileRedact";
    }
}
