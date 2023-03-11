package com.AutoVision.servingwebcontent.controller;

import com.AutoVision.servingwebcontent.domain.Card;
import com.AutoVision.servingwebcontent.domain.ParkingPlace;
import com.AutoVision.servingwebcontent.domain.User;
import com.AutoVision.servingwebcontent.repos.CarRepos;
import com.AutoVision.servingwebcontent.repos.CardRepos;
import com.AutoVision.servingwebcontent.repos.ParkingPlaceRepos;
import com.AutoVision.servingwebcontent.repos.StoryRepos;
import com.AutoVision.servingwebcontent.service.ParkingService;
import org.apache.commons.net.ntp.NTPUDPClient;
import org.apache.commons.net.ntp.TimeInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.IOException;
import java.net.InetAddress;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

@Controller
public class parkingUserController {
    @Autowired
    private CardRepos cardRepos;

    @Autowired
    private ParkingPlaceRepos parkingPlaceRepos;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @GetMapping("/view")
    public String parking(Model model) throws IOException {
        Iterable<ParkingPlace> parkingPlace = parkingPlaceRepos.findAll();
        int i = 0;
        int min = 32000000;
        for(ParkingPlace parking : parkingPlace)
        {
            if(parking.getStatus().equals("Открыт")){
                i++;
            }
            if(parking.getPriceBuy() < min){
                min = parking.getPriceBuy();
            }
        }
        model.addAttribute("min", min);
        model.addAttribute("kolvo", i);
        model.addAttribute("parking", parkingPlace);
        return "parkingUser";
    }

    @GetMapping("/view/{parking}")
    public String getParking(Model model, @PathVariable String parking){
        try {
            Long.parseLong(parking);
        } catch(NumberFormatException e){
            return "redirect:/view";
        }
        Long id = Long.parseLong (parking);
        ParkingPlace parkingPlace = parkingPlaceRepos.findByNumber(id);
        if(parkingPlace.getStatus().equals("Открыт")) {
            model.addAttribute("parking", parkingPlace);
            return "parkingView";
        }
        else{
            return "redirect:/view";
        }
    }

    @PostMapping("/view")
    public String buyParking(Model model,
                             @AuthenticationPrincipal User user,
                             @RequestParam(required = false) int priceBuy,
                             @RequestParam Long parkingPlaceId,
                             @RequestParam String number,
                             @RequestParam String srok,
                             @RequestParam String name,
                             @RequestParam String cvc) throws IOException {
        ParkingPlace parkingPlace = parkingPlaceRepos.getOne(parkingPlaceId);
        if(user.getActivationCode() != null){
            model.addAttribute("message", "Пожалуйста подтвердите почту для покупки места");
            model.addAttribute("parking", parkingPlace);
            return "parkingView";
        }
        if(!user.isFullUser()){
            model.addAttribute("message", "Пожалуйста пройдите верификацию для покупки места");
            model.addAttribute("parking", parkingPlace);
            return "parkingView";
        }
        Card card = cardRepos.findByNumber(number);
        if((passwordEncoder.matches(cvc, card.getCvc())) && (card.getDate().equals(srok)) && (card.getName().equals(name))){
            Long money = card.getMoney();
            if(priceBuy == 0)
            {
                if(parkingPlace.getPriceBuy() > money){
                    model.addAttribute("message", "На карте недостаточно средств");
                    model.addAttribute("parking", parkingPlace);
                    return "parkingView";
                }
                else{
                    money = money - parkingPlace.getPriceBuy();
                    card.setMoney(money);
                    cardRepos.save(card);
                }
            }
            else{
                if(parkingPlace.getPrice()*priceBuy > money){
                    model.addAttribute("message", "На карте недостаточно средств");
                    model.addAttribute("parking", parkingPlace);
                    return "parkingView";
                }
                else{
                    money = money - parkingPlace.getPrice()*priceBuy;
                    card.setMoney(money);
                    cardRepos.save(card);
                }
            }
        }
        else{
            model.addAttribute("message", "Неверная карта");
            model.addAttribute("parking", parkingPlace);
            return "parkingView";
        }
        if(parkingPlace.getStatus().equals("Открыт")) {
            if(priceBuy == 0)
            {
                parkingPlace.setStatus("Куплен");
                parkingPlace.setUser(user);
            }
            else{
                parkingPlace.setStatus("Арендован");
                parkingPlace.setStatus("Арендован");
                String TIME_SERVER = "time-a.nist.gov";
                NTPUDPClient timeClient = new NTPUDPClient();
                InetAddress inetAddress = InetAddress.getByName(TIME_SERVER);
                TimeInfo timeInfo = timeClient.getTime(inetAddress);
                long returnTime = timeInfo.getMessage().getTransmitTimeStamp().getTime();
                Date date1 = new Date(returnTime);
                Calendar calendar = new GregorianCalendar();
                calendar.setTime(date1);
                calendar.add(Calendar.MONTH, priceBuy);
                Date date = calendar.getTime();
                parkingPlace.setEndTime(date);
                parkingPlace.setUser(user);
            }
            parkingPlaceRepos.save(parkingPlace);
            model.addAttribute("parking", parkingPlace);
            return "redirect:/";
        }
        else{
            return "redirect:/view";
        }
    }

    @GetMapping("/card")
    public String card(Model model){
        return "card";
    }

    @PostMapping("/card")
    public String newCard(@RequestParam String number,
                          @RequestParam String date,
                          @RequestParam String name,
                          @RequestParam String cvc,
                          @RequestParam int moneyCard,
                          Model model){
        Long money = Long.valueOf(moneyCard);
        Card card = new Card();
        card.setNumber(number);
        card.setDate(date);
        card.setName(name);
        card.setCvc(passwordEncoder.encode(cvc));
        card.setMoney(money);
        cardRepos.save(card);
        return "card";
    }
}
