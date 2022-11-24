package com.AutoVision.servingwebcontent.service;

import com.AutoVision.servingwebcontent.domain.Car;
import com.AutoVision.servingwebcontent.domain.Role;
import com.AutoVision.servingwebcontent.domain.User;
import com.AutoVision.servingwebcontent.repos.CarRepos;
import com.AutoVision.servingwebcontent.repos.UserRepos;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class UserService implements UserDetailsService {

    @Autowired
    private UserRepos userRepos;

    @Autowired
    private MailSenderService mailSenderService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private CarRepos carRepos;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepos.findByUsername(username);

        if(user == null){
            throw new UsernameNotFoundException("Пользователь с таким логином не найден");
        }

        return user;
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

    public String addNewUser (User user, String repeatPassword){
        String pas = user.getPassword();
        if((pas.equals(repeatPassword)) && (repeatPassword != null) && (repeatPassword != ""))
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
            user.setPassword(passwordEncoder.encode(user.getPassword()));
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

    public void redactUser(User user, String username, String email, String password, Map<String, String> form){
        user.setUsername(username);
        user.setEmail(email);
        if((password != null) && (password != ""))
        {
            user.setPassword(passwordEncoder.encode(password));
        }

        Set<String> roles = Arrays.stream(Role.values()).map(Role::name).collect(Collectors.toSet());

        user.getRoles().clear();

        for (String key : form.keySet()){
            if (roles.contains(key)){
                user.getRoles().add(Role.valueOf(key));
            }
        }

        userRepos.save(user);
    }

    public void updateProfile(User user, String password, String email) {
        String userEmail = user.getEmail();

        boolean isEmailChange = ((email != null) && (!email.equals(userEmail)));
        if(isEmailChange){
            user.setEmail(email);

            user.setActivationCode(UUID.randomUUID().toString());

            String message = String.format(
                    "Приветствует Вас в системе Auto Vision \n" +
                            "Пожалуйста перейдите по ссылке ниже, чтобы подтвердить ваш email:\n" +
                            "http://localhost:8080/activate/%s",
                    user.getActivationCode()
            );

            mailSenderService.send(user.getEmail(), "Activation code", message);

        }

        if((password != null) && (password != "")){
            user.setPassword(passwordEncoder.encode(password));
        }

        userRepos.save(user);
    }

    public  List<User> findUser(String filter) {
        List<User> findUser = userRepos.findByUsernameLike(filter + '%');
         findUser.addAll(userRepos.findByEmailLike(filter + '%'));
        return findUser;
    }

    public List<Car> findUserCar(Long id){
        List<Car> cars = carRepos.findByUserId(id);
        return cars;
    }

    public String addCar(String model, String number, User user){
        Car car = new Car();
        if(carRepos.findByNumber(number) == null) {
            car.setModel(model);
            car.setNumber(number);
            car.setUser(user);
            carRepos.save(car);
            return "save";
        }
        else{
            return "Not save";
        }
    }
}
