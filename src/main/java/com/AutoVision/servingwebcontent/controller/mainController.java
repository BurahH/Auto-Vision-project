package com.AutoVision.servingwebcontent.controller;

import com.AutoVision.servingwebcontent.domain.Car;
import com.AutoVision.servingwebcontent.domain.ParkingPlace;
import com.AutoVision.servingwebcontent.domain.Story;
import com.AutoVision.servingwebcontent.domain.User;
import com.AutoVision.servingwebcontent.repos.CarRepos;
import com.AutoVision.servingwebcontent.repos.ParkingPlaceRepos;
import com.AutoVision.servingwebcontent.repos.StoryRepos;
import com.AutoVision.servingwebcontent.repos.UserRepos;
import com.AutoVision.servingwebcontent.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;


@Controller
public class mainController {
    @Autowired
    private ParkingPlaceRepos parkingPlaceRepos;

    @Autowired
    private CarRepos carRepos;

    @Autowired
    private StoryRepos storyRepos;

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
          return "redirect:/parking";
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