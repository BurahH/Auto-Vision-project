package com.AutoVision.servingwebcontent.controller;

import com.AutoVision.servingwebcontent.domain.Car;
import com.AutoVision.servingwebcontent.domain.Story;
import com.AutoVision.servingwebcontent.repos.CarRepos;
import com.AutoVision.servingwebcontent.repos.StoryRepos;
import com.AutoVision.servingwebcontent.repos.UserRepos;
import com.AutoVision.servingwebcontent.service.CarService;
import com.AutoVision.servingwebcontent.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/car")
public class carController {

    @Autowired
    private CarService carService;

    @Autowired
    private CarRepos carRepos;

    @Autowired
    private StoryRepos storyRepos;

    @Value("${upload.path}")
    private String uploadPath;

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping
    public String UserList(
            @RequestParam(required = false, defaultValue = "") String filter,
            Model model){
        if (filter != null && !filter.isEmpty()) {
            model.addAttribute("filtered", filter);
            model.addAttribute("cars", carService.findCar(filter));
            return "carList";
        }
        model.addAttribute("filtered", "");
        model.addAttribute("cars", carService.findAllCar());
        return "carList";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("{id}")
    public String userEditForm(@PathVariable Long id, Model model){
        Car car = carRepos.getOne(id);
        model.addAttribute("car", car);
        model.addAttribute("message", null);
        return "carEdit";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping
    public String carSave(
            @RequestParam String modelCar,
            @RequestParam String number,
            @RequestParam String vin,
            @RequestParam("carId") Long id,
            @RequestParam(required = false) String numberCar,
            MultipartFile sts,
            Model model) throws IOException {
        Car car = carService.findById(id);
        if ((!numberCar.equals(null)) && (!numberCar.equals("")) && (numberCar.equals(car.getNumber()))){
            List<Story> stories = storyRepos.findByCarId(id);
            storyRepos.deleteAll(stories);
            carRepos.delete(car);
            return "redirect:/car";
        }
        if((!numberCar.equals(null)) && (!numberCar.equals("")) && (!numberCar.equals(car.getNumber()))){
            model.addAttribute("classInscription", "alert alert-danger");
            model.addAttribute("message", "Удаление не удалось, неверный номер");
            model.addAttribute("car", car);
            return "carEdit";
        }

        if((car.getModel().equals(modelCar)) && (car.getNumber().equals(number)) && car.getVin().equals(vin) && sts.isEmpty())
        {
            model.addAttribute("classInscription", "alert alert-danger");
            model.addAttribute("message", "Не введено новых данных");
            model.addAttribute("car", car);
            return "carEdit";
        }
        else{
            Car findCar = carRepos.findByNumber(number);
            if((findCar != null) && (!findCar.getNumber().equals(number))){
                model.addAttribute("classInscription", "alert alert-danger");
                model.addAttribute("message", "Автомобиль с таким номером уже существует");
                model.addAttribute("car", car);
                return "carEdit";
            }
            findCar = carRepos.findByVin(number);
            if((findCar != null) && (!findCar.getVin().equals(vin))){
                model.addAttribute("classInscription", "alert alert-danger");
                model.addAttribute("message", "Автомобиль с таким VIN номером уже существует");
                model.addAttribute("car", car);
                return "carEdit";
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
            car.setVin(vin);
            car.setNumber(number);
            car.setModel(modelCar);
            carRepos.save(car);
            model.addAttribute("car", car);
            model.addAttribute("classInscription", "alert alert-success");
            model.addAttribute("message", "Автомобиль успешно изменен");
            return "carEdit";
        }
    }


}
