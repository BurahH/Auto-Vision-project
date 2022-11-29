package com.AutoVision.servingwebcontent.domain;

import javax.persistence.*;
import java.util.Date;

@Entity
public class ParkingPlace {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Long id;

    private Long number;

    private int price;
    private int priceBuy;
    private String status;

    private Date endTime;

    @ManyToOne(fetch = FetchType.EAGER, optional = true)
    @JoinColumn(name = "user_id")
    private User user;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public int getPriceBuy() {
        return priceBuy;
    }

    public void setPriceBuy(int priceBuy) {
        this.priceBuy = priceBuy;
    }

    public boolean checkHave(){
        if(status.equals(null)){
            return false;
        }
        else
        {
            return true;
        }
    }

    public Long getNumber() {
        return number;
    }

    public void setNumber(Long number) {
        this.number = number;
    }
}
