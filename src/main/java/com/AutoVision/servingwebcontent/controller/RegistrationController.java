package com.AutoVision.servingwebcontent.controller;

import com.AutoVision.servingwebcontent.domain.User;
import com.AutoVision.servingwebcontent.repos.UserRepos;
import com.AutoVision.servingwebcontent.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.Map;

@Controller
public class RegistrationController {

    @Autowired
    private UserService userService;

    @GetMapping("/registration")
    public String registration(){
        return "registration";
    }

    @PostMapping("/registration")
    public String addUser(User user, String repeatpassword, Map<String, Object> model){
       String check = userService.addNewUser(user, repeatpassword);

       if(check == "Email repeats"){
            model.put("message", "Пользователь с такой почтой уже существует");
            return "registration";
       }
       else if(check == "User repeats"){
           model.put("message", "Пользователь с таким логином уже существует");
           return "registration";
       }
       else if (check == "User add"){
           model.put("message", "Пожалуйста подтвердите почту, перейдя по ссылке");
           return "redirect:/login";
       }
       else{
           model.put("message", "Пароли не совпадают");
           return "registration";
       }
    }

    @GetMapping("/activate/{code}")
    public String activate(Model model, @PathVariable String code){
        boolean isActivated = userService.activateUser(code);

        if(isActivated){
            model.addAttribute("message", "Почта успешно подтверждена");
        }
        else{
            model.addAttribute("message", "Код активации не найден");
        }

        return "login";
    }
}
