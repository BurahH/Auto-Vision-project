package com.AutoVision.servingwebcontent.controller;

import com.AutoVision.servingwebcontent.domain.Role;
import com.AutoVision.servingwebcontent.domain.User;
import com.AutoVision.servingwebcontent.repos.UserRepos;
import com.AutoVision.servingwebcontent.service.UserService;
import org.dom4j.rule.Mode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserRepos userRepos;

    @Autowired
    private UserService userService;

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping
    public String UserList(
            @RequestParam(required = false, defaultValue = "") String filter,
            Model model){
        if (filter != null && !filter.isEmpty()) {
            User user = userService.findUser(filter);
            model.addAttribute("filtered", filter);
            model.addAttribute("users", user);
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
        return "userEdit";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping
    public String userSave(
            @RequestParam String username,
            @RequestParam String email,
            @RequestParam Map<String, String> form,
            @RequestParam String password,
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

        userService.redactUser(user, username, email, password, form);

        model.addAttribute("classInscription", "alert alert-success");
        model.addAttribute("message", "Пользователь успешно изменен");
        model.addAttribute("user", user);
        model.addAttribute("roles", Role.values());
        return "userEdit";
    }

    @GetMapping("profile")
    public String getProfile(Model model, @AuthenticationPrincipal User user){
        model.addAttribute("username", user.getUsername());
        model.addAttribute("email", user.getEmail());

        return "profile";
    }

    @PostMapping("profile")
    public String updateProfile(
            @AuthenticationPrincipal User user,
            @RequestParam String password,
            @RequestParam String email
    ){
        userService.updateProfile(user, password, email);

        return "redirect:/user/profile";
    }
}
