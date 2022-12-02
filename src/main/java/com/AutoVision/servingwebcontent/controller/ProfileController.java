package com.AutoVision.servingwebcontent.controller;

import com.AutoVision.servingwebcontent.domain.Car;
import com.AutoVision.servingwebcontent.domain.Role;
import com.AutoVision.servingwebcontent.domain.Story;
import com.AutoVision.servingwebcontent.domain.User;
import com.AutoVision.servingwebcontent.repos.CarRepos;
import com.AutoVision.servingwebcontent.repos.StoryRepos;
import com.AutoVision.servingwebcontent.repos.UserRepos;
import com.AutoVision.servingwebcontent.service.CarService;
import com.AutoVision.servingwebcontent.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
    private CarRepos carRepos;

    @Autowired
    private CarService carService;

    @Autowired
    private StoryRepos storyRepos;

    @Autowired
    private UserService userService;

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("profile")
    public String getProfile(Model model, @AuthenticationPrincipal User user){
        model.addAttribute("user", user);
        model.addAttribute("message", null);

        List<Car> cars = userService.findUserCar(user.getId());
        model.addAttribute("car", cars);

        return "profile";
    }

    @PostMapping("profile")
    public String newCar(Model model, @AuthenticationPrincipal User user,
                         @RequestParam String modelCar,
                         @RequestParam String number,
                         @RequestParam String vin,
                         MultipartFile sts) throws IOException {
        String message = userService.addCar(modelCar, number, user, vin, sts);
        if(message == "Not save"){
            model.addAttribute("message", "Автомобиль с таким номер/vin уже существует");
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
        model.addAttribute("username", user.getUsername());
        model.addAttribute("email", user.getEmail());

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
            if(user.getRoles().contains(Role.FULL_USER)) {
                user.getRoles().remove(Role.FULL_USER);
            }
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
            if(user.getRoles().contains(Role.FULL_USER)) {
                user.getRoles().remove(Role.FULL_USER);
            }
        }
        if(!user.checkName())
        {
            user.setName(name);
        }
        else {
            if (!user.getName().equals(name)) {
                user.setName(name);
                if (user.getRoles().contains(Role.FULL_USER)) {
                    user.getRoles().remove(Role.FULL_USER);
                }
            }
        }
        if(!user.checkNumber())
        {
            user.setNumber(number);
        }
        else {
            if (!user.getNumber().equals(number)) {
                user.setNumber(number);
                if (user.getRoles().contains(Role.FULL_USER)) {
                    user.getRoles().remove(Role.FULL_USER);
                }
            }
        }
        userRepos.save(user);

        model.addAttribute("user", user);

        return "profileRedact";
    }

    @GetMapping("/profile/car/{car}")
    public String getEditCar(Model model,
                             @AuthenticationPrincipal User user,
                             @PathVariable String car){
        try {
            Long.parseLong(car);
        } catch(NumberFormatException e){
            return "redirect:/profile";
        }
        Long id = Long.parseLong (car);
        Car carEdit = carRepos.getOne(id);
        if(!carEdit.getUser().getId().equals(user.getId()))
        {
            return "redirect:/profile";
        }
        model.addAttribute("car", carEdit);

        return "ProfileRedactCar";
    }

    @PostMapping("/profile/car/{car}")
    public String editCar( @RequestParam String modelCar,
                           @RequestParam String number,
                           @RequestParam String vin,
                           @RequestParam("carId") Long id,
                           @RequestParam(required = false) String numberCar,
                           MultipartFile sts,
                           Model model) throws IOException{
        Car car = carService.findById(id);
        if ((!numberCar.equals(null)) && (!numberCar.equals("")) && (numberCar.equals(car.getNumber()))){
            List<Story> stories = storyRepos.findByCarId(id);
            storyRepos.deleteAll(stories);
            carRepos.delete(car);
            return "redirect:/profile";
        }
        if((!numberCar.equals(null)) && (!numberCar.equals("")) && (!numberCar.equals(car.getNumber()))){
            model.addAttribute("classInscription", "alert alert-danger");
            model.addAttribute("message", "Удаление не удалось, неверный номер");
            model.addAttribute("car", car);
            return "ProfileRedactCar";
        }

        if((car.getModel().equals(modelCar)) && (car.getNumber().equals(number)) && car.getVin().equals(vin) && sts.isEmpty())
        {
            model.addAttribute("classInscription", "alert alert-danger");
            model.addAttribute("message", "Не введено новых данных");
            model.addAttribute("car", car);
            return "ProfileRedactCar";
        }
        else{
            Car findCar = carRepos.findByNumber(number);
            if((findCar != null) && (!findCar.getNumber().equals(number))){
                model.addAttribute("classInscription", "alert alert-danger");
                model.addAttribute("message", "Автомобиль с таким номером уже существует");
                model.addAttribute("car", car);
                return "ProfileRedactCar";
            }
            findCar = carRepos.findByVin(number);
            if((findCar != null) && (!findCar.getVin().equals(vin))){
                model.addAttribute("classInscription", "alert alert-danger");
                model.addAttribute("message", "Автомобиль с таким VIN номером уже существует");
                model.addAttribute("car", car);
                return "ProfileRedactCar";
            }
            if(!sts.isEmpty()){
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }
                String uuidFile = UUID.randomUUID().toString();
                String resultFilename = uuidFile + "." + sts.getOriginalFilename();
                sts.transferTo(new File(uploadPath + "/" + resultFilename));
                car.setSts(resultFilename);
            }
            car.setActive(false);
            car.setVin(vin);
            car.setNumber(number);
            car.setModel(modelCar);
            carRepos.save(car);
            model.addAttribute("car", car);
            model.addAttribute("classInscription", "alert alert-success");
            model.addAttribute("message", "Автомобиль успешно изменен");
            return "ProfileRedactCar";
        }
    }
}
