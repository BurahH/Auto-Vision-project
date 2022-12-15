package com.AutoVision.servingwebcontent.controller;

import com.AutoVision.servingwebcontent.domain.Car;
import com.AutoVision.servingwebcontent.domain.Role;
import com.AutoVision.servingwebcontent.domain.Story;
import com.AutoVision.servingwebcontent.domain.User;
import com.AutoVision.servingwebcontent.repos.CarRepos;
import com.AutoVision.servingwebcontent.repos.StoryRepos;
import com.AutoVision.servingwebcontent.repos.UserRepos;
import com.AutoVision.servingwebcontent.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/checklist")
public class verificationController {
    @Autowired
    private UserRepos userRepos;

    @Autowired
    private UserService userService;

    @Autowired
    private StoryRepos storyRepos;

    @Autowired
    private CarRepos carRepos;

    @PreAuthorize("hasAuthority('WATCHMAN')")
    @GetMapping
    public String UserListCheck(Model model) {
        List<User> userList = userService.findAlluser();
        List<User> userListAmount = userService.findAlluser();
        if (userList.size() != 0) {
            for (User user : userListAmount) {
                if (userList.size() != 0) {
                    if ((user.isFullUser()) || (user.isAdmin()) || (user.isWatchman()) || (user.checkDate() != true)) {
                        userList.remove(user);
                    }
                }
            }
        }
        model.addAttribute("users", userList);
        return "userCheck";
    }

    @PreAuthorize("hasAuthority('WATCHMAN')")
    @GetMapping("{user}")
    public String userCheckEdit(@PathVariable User user,
                                @RequestParam(required = false) Long id,
                                Model model){
        if(id != null){
            User user1 = userRepos.getOne(id);
            String message = String.format(
                    "Вас приветствует система Auto Vision \n" +
                            "Введенные вами личные данные были признаны неверными, пожалуйста проверьте и введите их еще раз\n"
            );
            userService.getMessage(user, message);
            user.setName(null);
            user.setNumber(null);
            user.setPhoto(null);
            user.setPhotoOsago(null);
            userRepos.save(user);
            return "redirect:/checklist";
        }
        model.addAttribute("user", user);
        return "userCheckEdit";
    }

    @PreAuthorize("hasAuthority('WATCHMAN')")
    @PostMapping
    public String userGetFull(@RequestParam("userId") User user, Model model){
        user.getRoles().add(Role.FULL_USER);
        userRepos.save(user);

        model.addAttribute("user", user);
        return "redirect:/checklist";
    }

    @PreAuthorize("hasAuthority('WATCHMAN')")
    @GetMapping("/carlist")
    public String carListCheck(Model model) {
        List<Car> carList = carRepos.findAll();
        List<Car> carListAmount = carRepos.findAll();
        if (carList.size() != 0) {
            for (Car car: carListAmount) {
                if (carList.size() != 0) {
                    if (car.isActive()) {
                        carList.remove(car);
                    }
                }
            }
        }
        model.addAttribute("cars", carList);
        return "carCheck";
    }

    @PreAuthorize("hasAuthority('WATCHMAN')")
    @GetMapping("/carlist/{id}")
    public String carCheckEdit(@PathVariable Long id,
                               @RequestParam(required = false) Long carid,
                               Model model){
        Car car = carRepos.getOne(id);
        if(carid != null){
            User user1 = userRepos.getOne(id);
            String message = String.format(
                    "Вас приветствует система Auto Vision \n" +
                            "Введенные вами данные об автомобиле " + car.getModel() +" были признаны неверными, пожалуйста проверьте и введите их еще раз\n"
            );
            List<Story> stories = storyRepos.findByCarId(id);
            storyRepos.deleteAll(stories);
            carRepos.delete(car);
            userService.getMessage(car.getUser(), message);
            return "redirect:/checklist/carlist";
        }
        model.addAttribute("car", car);
        return "carCheckEdit";
    }

    @PreAuthorize("hasAuthority('WATCHMAN')")
    @PostMapping("/carlist")
    public String carGetActive(@RequestParam("carId") Long id, Model model){
        Car car = carRepos.getOne(id);
        car.setActive(true);
        carRepos.save(car);

        model.addAttribute("car", car);
        return "redirect:/checklist/carlist";
    }
}
