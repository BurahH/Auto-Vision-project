package com.AutoVision.servingwebcontent.controller;

import com.AutoVision.servingwebcontent.domain.User;
import com.AutoVision.servingwebcontent.repos.UserRepos;
import com.AutoVision.servingwebcontent.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.validation.Valid;
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
    public String addUser(@Valid User user,
                          @RequestParam("repeatPassword") String passwordConfirm,
                          BindingResult bindingResult,
                          Model model){
        if(bindingResult.hasErrors()){
            Map<String, String> errors = ControllerUtils.getError(bindingResult);

            model.mergeAttributes(errors);
            return "registration";
        }
        if(passwordConfirm == null){
            model.addAttribute("repeatPassword", "Поле повторите пароль не может быть пустым");
        }

        String check = userService.addNewUser(user, passwordConfirm);

       if(check == "Email repeats"){
            model.addAttribute("emailError", "Пользователь с такой почтой уже существует");
            return "registration";
       }
       else if(check == "User repeats"){
           model.addAttribute("usernameError", "Пользователь с таким логином уже существует");
           return "registration";
       }
       else if (check == "User add"){
           model.addAttribute("message", "Пожалуйста подтвердите почту, перейдя по ссылке");
           return "redirect:/login";
       }
       else{
           model.addAttribute("passwordError", "Пароли не совпадают");
           return "registration";
       }
    }

    @GetMapping("/activate/{code}")
    public String activate(Model model, @PathVariable String code){
        boolean isActivated = userService.activateUser(code);

        if(isActivated){
            model.addAttribute("messageType", "alert alert-success");
            model.addAttribute("message", "Почта успешно подтверждена");
        }
        else{
            model.addAttribute("messageType", "alert alert-danger");
            model.addAttribute("message", "Код активации не найден");
        }

        return "login";
    }
}
