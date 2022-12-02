package com.AutoVision.servingwebcontent.controller;

import com.AutoVision.servingwebcontent.domain.*;
import com.AutoVision.servingwebcontent.repos.*;
import com.AutoVision.servingwebcontent.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Set;
import java.util.UUID;


@Controller
public class mainController {
    @Autowired
    private UserRepos userRepos;

    @Autowired
    private ParkingPlaceRepos parkingPlaceRepos;

    @Autowired
    private CarRepos carRepos;

    @Autowired
    private StoryRepos storyRepos;

    @Autowired
    private UserService userService;

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/")
    public String greeting(Model model,
    @AuthenticationPrincipal User user) {
      if(user.isUser())
        {
            if(parkingPlaceRepos.findByUserId(user.getId()).size() != 0)
            {
                List<ParkingPlace> parkingPlace = parkingPlaceRepos.findByUserId(user.getId());
                model.addAttribute("parkingPlace", parkingPlace);
            }
            else{
                model.addAttribute("parkingPlace", null);
            }
            List<Car> cars = carRepos.findByUserId(user.getId());
            List<Story> story = null;
            for (Car car : cars)
            {
                if(story == null)
                {
                    if (storyRepos.findByCarId(car.getId()).size() != 0) {
                        story = storyRepos.findByCarId(car.getId());
                    }
                }
                else {
                    if (storyRepos.findByCarId(car.getId()).size() != 0) {
                        story.addAll(storyRepos.findByCarId(car.getId()));
                    }
                }
            }
            model.addAttribute("story", story);
            return "Main";
        }
        else if(user.isWatchman())
        {
            return "camera";
        }
        else {
            return "greeting";
        }

    }

    /*@GetMapping("/main")
    public String main(@RequestParam(required = false, defaultValue = "") String filter, Model model){
        Iterable<Message> messages = messageRepos.findAll();

        if (filter != null && !filter.isEmpty()) {
            messages = messageRepos.findByText(filter);
        }

        model.addAttribute("messages", messages);
        model.addAttribute("filter", filter);

        return "main";
    }

    @PostMapping("/main")
    public String add(@RequestParam String text,
                      @RequestParam String tag,
                      Model model,
                      @RequestParam("file")MultipartFile file) throws IOException {
        Message message = new Message(text, tag);

        if(file != null && !file.getOriginalFilename().isEmpty()){
            File uploadDir = new File(uploadPath);
            if(!uploadDir.exists()){
                uploadDir.mkdir();
            }

            String uuidFile = UUID.randomUUID().toString();
            String resultFilename = uuidFile + "." + file.getOriginalFilename();

            file.transferTo(new File(uploadPath + "/" + resultFilename));

            message.setFilename(resultFilename);
        }

        messageRepos.save(message);
        Iterable<Message> messages = messageRepos.findAll();
        model.addAttribute("messages", messages);
        return "main";
    }*/
}