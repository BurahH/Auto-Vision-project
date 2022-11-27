package com.AutoVision.servingwebcontent.controller;

import com.AutoVision.servingwebcontent.domain.Car;
import com.AutoVision.servingwebcontent.domain.Role;
import com.AutoVision.servingwebcontent.domain.User;
import com.AutoVision.servingwebcontent.repos.CarRepos;
import com.AutoVision.servingwebcontent.repos.UserRepos;
import com.AutoVision.servingwebcontent.service.CarService;
import com.AutoVision.servingwebcontent.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.transaction.Transactional;
import java.util.Map;

@Transactional
@Controller
@RequestMapping("/car")
public class carController {
    @Autowired
    private UserRepos userRepos;

    @Autowired
    private UserService userService;

    @Autowired
    private CarService carService;

    @Autowired
    private CarRepos carRepos;

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
        Car car = carRepos.findById(id);
        model.addAttribute("car", car);
        model.addAttribute("message", null);
        return "carEdit";
    }

    @PreAuthorize("hasAuthority('ADMIN')")          //TODO Удаления автомоблиля + у пользователя
    @PostMapping
    public String carSave(
            @RequestParam String modelCar,
            @RequestParam String number,
            @RequestParam String vin,
            @RequestParam("carId") Long id,
            @RequestParam(required = false) String numberCar,
            Model model) {
        Car car = carRepos.findById(id);

        if ((numberCar != null) && (numberCar != "") && (numberCar.equals(car.getNumber()))){
            carRepos.deleteById(car.getId());
            return "redirect:/car";
        }
        if((numberCar != null) && (numberCar != "") && (!numberCar.equals(car.getNumber()))){
            model.addAttribute("classInscription", "alert alert-danger");
            model.addAttribute("message", "Удаление не удалось, неверный номер");
            model.addAttribute("car", car);
            return "carEdit";
        }

        if((car.getModel().equals(model)) && (car.getNumber().equals(number)) && car.getVin().equals(vin))
        {
            model.addAttribute("classInscription", "alert alert-danger");
            model.addAttribute("message", "Не введено новых данных");
            model.addAttribute("car", car);
            return "carEdit";
        }
        else{
            Car findCar = carRepos.findByNumber(number);
            if((findCar != null)){
                model.addAttribute("classInscription", "alert alert-danger");
                model.addAttribute("message", "Автомобиль с таким номером уже существует");
                model.addAttribute("car", car);
                return "carEdit";
            }
            findCar = carRepos.findByVin(number);
            if((findCar != null)){
                model.addAttribute("classInscription", "alert alert-danger");
                model.addAttribute("message", "Автомобиль с таким VIN номером уже существует");
                model.addAttribute("car", car);
                return "carEdit";
            }
            car.setVin(vin);
            car.setNumber(number);
            car.setModel(modelCar);
            carRepos.save(car);
            model.addAttribute("car", car);
            return "carEdit";
        }
    }
}
