package com.AutoVision.servingwebcontent.controller;

import com.AutoVision.servingwebcontent.domain.*;
import com.AutoVision.servingwebcontent.repos.CarRepos;
import com.AutoVision.servingwebcontent.repos.ParkingPlaceRepos;
import com.AutoVision.servingwebcontent.repos.StoryRepos;
import com.AutoVision.servingwebcontent.repos.UserRepos;
import com.AutoVision.servingwebcontent.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserRepos userRepos;

    @Autowired
    private CarRepos carRepos;

    @Autowired
    private StoryRepos storyRepos;

    @Autowired
    private ParkingPlaceRepos parkingPlaceRepos;

    @Autowired
    private UserService userService;

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping
    public String UserList(
            @RequestParam(required = false, defaultValue = "") String filter,
            Model model){
        if (filter != null && !filter.isEmpty()) {
            model.addAttribute("filtered", filter);
            model.addAttribute("users", userService.findUser(filter));
            return "userList";
        }
        model.addAttribute("filtered", "");
        model.addAttribute("users", userService.findAlluser());
        return "userList";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("{user}")
    public String userEditForm(@PathVariable User user, Model model){
        model.addAttribute("user", user);
        model.addAttribute("roles", Role.values());
        model.addAttribute("message", null);
        return "userEdit";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping
    public String userSave(
            @RequestParam String username,
            @RequestParam String email,
            @RequestParam Map<String, String> form,
            @RequestParam String password,
            @RequestParam String name,
            @RequestParam String number,
            @RequestParam("userId") User user,
            @RequestParam(required = false) String adminLogin,
            MultipartFile photo,
            MultipartFile photoOsago,
            Model model) throws IOException {
        String usernameDef = user.getUsername();
        if ((adminLogin != null) && (adminLogin != "") && (adminLogin.equals(usernameDef))){
            List<Car> cars = carRepos.findByUserId(user.getId());
            for(Car car : cars) {
                List<Story> stories = storyRepos.findByCarId(car.getId());
                storyRepos.deleteAll(stories);
            }
            List<ParkingPlace> parking = parkingPlaceRepos.findByUserId(user.getId());
            for(ParkingPlace parkingPlace : parking) {
                parkingPlace.setUser(null);
            }
            carRepos.deleteAll(cars);
            userRepos.deleteById(user.getId());
            return "redirect:/user";
        }
        if((!adminLogin.equals(null)) && (!adminLogin.equals("")) && (!adminLogin.equals(usernameDef))){
            model.addAttribute("classInscription", "alert alert-danger");
            model.addAttribute("message", "Удаление не удалось, неверный логин");
            model.addAttribute("user", user);
            model.addAttribute("roles", Role.values());
            return "userEdit";
        }

        if((!user.haveNew(username, email, name, number)) && (photoOsago.isEmpty()) && (photo.isEmpty()) && (((password.equals(null)) || (password.equals(""))))){
            Set<String> roles = Arrays.stream(Role.values()).map(Role::name).collect(Collectors.toSet());
            User newUser = new User();
            Set<Role> roles1 = new HashSet<>();
            roles1.addAll(user.getRoles());
            newUser.setRoles(roles1);
            newUser.getRoles().clear();

            for (String key : form.keySet()){
                if (roles.contains(key)){
                    newUser.getRoles().add(Role.valueOf(key));
                }
            }
            if(user.getRoles().equals(newUser.getRoles())){
                model.addAttribute("classInscription", "alert alert-danger");
                model.addAttribute("message", "Не введено новых данных");
                model.addAttribute("user", user);
                model.addAttribute("roles", Role.values());
                return "userEdit";
            }
        }

        User userFromDb = userRepos.findByUsername(username);

        if ((userFromDb != null) && (user.getId() != userFromDb.getId())) {
            model.addAttribute("classInscription", "alert alert-danger");
            model.addAttribute("message", "Пользователь с таким логином уже существует");
            model.addAttribute("user", user);
            model.addAttribute("roles", Role.values());
            return "userEdit";
        }

        userFromDb = userRepos.findByEmail(email);

        if ((userFromDb != null) && (user.getId() != userFromDb.getId())) {
            model.addAttribute("classInscription", "alert alert-danger");
            model.addAttribute("message", "Пользователь с такой почтой уже существует");
            model.addAttribute("user", user);
            model.addAttribute("roles", Role.values());
            return "userEdit";
        }

        userService.redactUser(user, username, email, password, form, name, number, photo, photoOsago);

        model.addAttribute("classInscription", "alert alert-success");
        model.addAttribute("message", "Пользователь успешно изменен");
        model.addAttribute("user", user);
        model.addAttribute("roles", Role.values());
        return "userEdit";
    }
}
