package com.AutoVision.servingwebcontent.controller;

import com.AutoVision.servingwebcontent.domain.Role;
import com.AutoVision.servingwebcontent.domain.User;
import com.AutoVision.servingwebcontent.repos.UserRepos;
import com.AutoVision.servingwebcontent.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/user")
@PreAuthorize("hasAuthority('ADMIN')")
public class UserController {
    @Autowired
    private UserRepos userRepos;

    @Autowired
    private UserService userService;

    @GetMapping
    public String UserList(Model model){
        model.addAttribute("users", userService.findAlluser());
        return "userList";
    }

    @GetMapping("{user}")
    public String userEditForm(@PathVariable User user, Model model){
        model.addAttribute("user", user);
        model.addAttribute("roles", Role.values());
        return "userEdit";
    }

    @PostMapping
    public String userSave(
            @RequestParam String username,
            @RequestParam String email,
            @RequestParam Map<String, String> form,
            @RequestParam("userId") User user,
                           Model model){
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

        user.setUsername(username);
        user.setEmail(email);

        Set<String> roles = Arrays.stream(Role.values()).map(Role::name).collect(Collectors.toSet());

        user.getRoles().clear();

        for (String key : form.keySet()){
            if (roles.contains(key)){
                user.getRoles().add(Role.valueOf(key));
            }
        }

        userRepos.save(user);

        model.addAttribute("classInscription", "alert alert-success");
        model.addAttribute("message", "Пользователь успешно изменен");
        model.addAttribute("user", user);
        model.addAttribute("roles", Role.values());
        return "userEdit";
    }
}
