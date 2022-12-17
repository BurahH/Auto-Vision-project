package com.AutoVision.servingwebcontent.service;

import com.AutoVision.servingwebcontent.domain.Car;
import com.AutoVision.servingwebcontent.domain.Role;
import com.AutoVision.servingwebcontent.domain.User;
import com.AutoVision.servingwebcontent.repos.CarRepos;
import com.AutoVision.servingwebcontent.repos.UserRepos;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
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

    @Value("${upload.path}")
    private String uploadPath;

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

    public void redactUser (User user, String username, String email, String password, Map<String, String> form, String name, String number, MultipartFile photo, MultipartFile photoOsago) throws IOException {
        user.setUsername(username);
        user.setEmail(email);
        user.setNumber(number);
        user.setName(name);

        if(!photo.isEmpty()) {
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            String uuidFile = UUID.randomUUID().toString();
            String resultFilename = uuidFile + "." + photo.getOriginalFilename();
            photo.transferTo(new File(uploadPath + "/" + resultFilename));
            user.setPhoto(resultFilename);
        }

        if(!photoOsago.isEmpty()) {
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            String uuidFile = UUID.randomUUID().toString();
            String resultFilename = uuidFile + "." + photoOsago.getOriginalFilename();
            photoOsago.transferTo(new File(uploadPath + "/" + resultFilename));
            user.setPhotoOsago(resultFilename);
        }

        if((!password.equals(null)) && (!password.equals("")))
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

    public boolean updateProfile(User user, String password, String email) {
        String userEmail = user.getEmail();

        boolean isEmailChange = ((email != null) && (!email.equals(userEmail)));
        User user1 = userRepos.findByEmail(email);
        if((user1 != null) && (user1.getEmail().equals(email))){
            return false;
        }
        if((isEmailChange)){
            user.setEmail(email);

            user.setActivationCode(UUID.randomUUID().toString());

            String message = String.format(
                    "Приветствует Вас в системе Auto Vision \n" +
                            "Пожалуйста перейдите по ссылке ниже, чтобы подтвердить ваш email:\n" +
                            "http://localhost:8080/activate/%s\nДо подтверждения email доступ к аккаунту закрыт",
                    user.getActivationCode()
            );

            mailSenderService.send(user.getEmail(), "Activation code", message);
        }

        if((password != null) && (password != "")){
            user.setPassword(passwordEncoder.encode(password));
        }

        userRepos.save(user);
        return true;
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

    public String addCar(String model, String number, User user, String vin, MultipartFile sts) throws IOException {
        Car car = new Car();
        if((carRepos.findByNumber(number) == null) && (carRepos.findByVin(vin) == null)) {
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            String uuidFile = UUID.randomUUID().toString();
            String resultFilename = uuidFile + "." + sts.getOriginalFilename();
            sts.transferTo(new File(uploadPath + "/" + resultFilename));
            car.setSts(resultFilename);
            car.setVin(vin);
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

    public void getMessage(User user, String message){
        mailSenderService.send(user.getEmail(), "Отказано в верификации", message);
    }

    public String recoveryUser(String email){
        User user = userRepos.findByEmail(email);
        if(user == null)
        {
            return "Пользователь с таким email не найден";
        }
        else{
            String newPassword = UUID.randomUUID().toString();
            user.setPassword(passwordEncoder.encode(newPassword));
            userRepos.save(user);
            mailSenderService.send(user.getEmail(), "Востановление пароля", "Ваш пароль был сброшен, новый пароль: " + newPassword + "\n Пожалуйста изменить его после входа");
            return "Письмо с паролем отправлено на почту";
        }

    }
}
