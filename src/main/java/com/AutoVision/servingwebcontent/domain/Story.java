package com.AutoVision.servingwebcontent.domain;

import javax.persistence.*;
import java.util.Date;

@Entity
public class Story {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Long id;

    private Date time;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "car_id")
    private Car car;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Car getCar() {
        return car;
    }

    public void setCar(Car car) {
        this.car = car;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }
}
