package com.AutoVision.servingwebcontent.service;

import com.AutoVision.servingwebcontent.domain.Role;
import com.AutoVision.servingwebcontent.domain.User;
import com.AutoVision.servingwebcontent.repos.UserRepos;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.UUID;

@Service
public class UserService implements UserDetailsService {

    @Autowired
    private UserRepos userRepos;

    @Autowired
    private MailSenderService mailSenderService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return userRepos.findByUsername(username);
    }

    public boolean searchUser(User user){
        User userFromDb = userRepos.findByUsername(user.getUsername());

        if (userFromDb != null) {
            return true;
        }
        else{
            return false;
        }
    }

    public boolean searchEmail(User user) {
        User userFromDb = userRepos.findByEmail(user.getEmail());

        if (userFromDb != null) {
            return true;
        }
        else{
            return false;
        }
    }

    public String addNewUser (User user, String repeatpassword){
        String pas = user.getPassword();
        String pasrepeat = repeatpassword;
        if(pas.equals(pasrepeat))
        {
            boolean userExists = searchUser(user);

            if (userExists) {
                return "User repeats";
            }

            boolean emailExists = searchEmail(user);

            if (emailExists) {
                return "Email repeats";
            }

            user.setActive(false);
            user.setRoles(Collections.singleton(Role.USER));
            user.setActivationCode(UUID.randomUUID().toString());
            userRepos.save(user);

            String message = String.format(
                    "Приветствует Вас в системе Auto Vision \n" +
                            "Пожалуйста перейдите по ссылке ниже, чтобы подстветдить вам email:\n" +
                            "http://localhost:8080/activate/%s",
                    user.getActivationCode()
            );

            mailSenderService.send(user.getEmail(), "Activation code", message);

            return "User add";
        }
        else {
            return "Password not repeat";
        }
    }

    public List<User> findAlluser() {
       return userRepos.findAll();
    }

    public boolean activateUser(String code) {
        User user = userRepos.findByActivationCode(code);

        if(user == null){
            return false;
        }
        user.setActivationCode(null);

        user.setActive(true);

        userRepos.save(user);

        return true;
    }
}
