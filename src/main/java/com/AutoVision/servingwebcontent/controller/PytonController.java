package com.AutoVision.servingwebcontent.controller;

import com.AutoVision.servingwebcontent.domain.Car;
import com.AutoVision.servingwebcontent.domain.ParkingPlace;
import com.AutoVision.servingwebcontent.domain.Role;
import com.AutoVision.servingwebcontent.domain.Story;
import com.AutoVision.servingwebcontent.repos.CarRepos;
import com.AutoVision.servingwebcontent.repos.ParkingPlaceRepos;
import com.AutoVision.servingwebcontent.repos.StoryRepos;
import com.AutoVision.servingwebcontent.repos.UserRepos;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
public class PytonController {
    @Autowired
    private UserRepos userRepos;

    @Autowired
    private ParkingPlaceRepos parkingPlaceRepos;

    @Autowired
    private CarRepos carRepos;

    @Autowired
    private StoryRepos storyRepos;

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/checkAuto")
    public String getIdent(Model model){
        return "cameraCheck";
    }

    @PostMapping("/checkAuto")
    public String ident(Model model,
                        @RequestParam MultipartFile photo
    ) throws IOException {
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
        String uuidFile = UUID.randomUUID().toString();
        String resultFilename = uuidFile + "." + photo.getOriginalFilename();
        photo.transferTo(new File(uploadPath + "/" + resultFilename));
        FileWriter writer = new FileWriter("C:\\Users\\irgal\\Desktop\\project\\Auto-Vision-project\\src\\main\\python\\nameFile.txt", false);
        writer.write(resultFilename);
        writer.flush();
        String pythonFile = "C:\\Users\\irgal\\Desktop\\project\\Auto-Vision-project\\src\\main\\python\\main.py";
        Process p = Runtime.getRuntime().exec(new String[]{"python", pythonFile});
        BufferedReader br = new BufferedReader(new InputStreamReader(p.getInputStream(), "windows-1251"));
        String s = br.readLine();
        Car car = carRepos.findByNumber(s);
        boolean check = true;
        if(car == null){
            check = false;
        }
        else{
            Story story = new Story();
            Date date = new Date();
            story.setTime(date);
            story.setCar(car);
            storyRepos.save(story);
        }
        model.addAttribute("access", check);
        model.addAttribute("number", s);
        return "cameraCheck";
    }
}
