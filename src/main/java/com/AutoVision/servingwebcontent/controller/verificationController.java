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

import java.util.List;

@Controller
@RequestMapping("/checklist")
public class verificationController {
    @Autowired
    private UserRepos userRepos;

    @Autowired
    private UserService userService;

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
    public String userCheckEdit(@PathVariable User user, Model model){
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
}
