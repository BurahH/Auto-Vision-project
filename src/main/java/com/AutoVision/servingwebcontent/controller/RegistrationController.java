package com.AutoVision.servingwebcontent.controller;

import com.AutoVision.servingwebcontent.domain.Role;
import com.AutoVision.servingwebcontent.domain.User;
import com.AutoVision.servingwebcontent.repos.UserRepos;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.Collections;
import java.util.Map;

@Controller
public class RegistrationController {

    @Autowired
    private UserRepos userRepos;

    @GetMapping("/registration")
    public String registration(){
        return "registration";
    }

    @PostMapping("/registration")
    public String addUser(User user, String repeatpassword, Map<String, Object> model){
        String pas = user.getPassword();
        String pasrepeat = repeatpassword;
        if(pas.equals(pasrepeat))
        {
            User userFromDb = userRepos.findByUsername(user.getUsername());

            if (userFromDb != null) {
                model.put("message", "User exists!");
                return "registration";
            }

            user.setActive(true);
            user.setRoles(Collections.singleton(Role.USER));
            userRepos.save(user);

            return "redirect:/login";
        }
        else {
            model.put("message", "Пароли не совпадают");
            return "registration";
        }
    }
}
