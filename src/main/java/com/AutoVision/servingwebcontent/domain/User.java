package com.AutoVision.servingwebcontent.domain;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import java.util.Collection;
import java.util.Set;

@Entity
@Table(name = "usr")
public class User implements UserDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @NotBlank(message = "Поле логин не может быть пустым")
    private String username;

    @NotBlank(message = "Поле пароль не может быть пустым")
    private String password;

    private boolean active;

    @Email(message = "Поле email введено неккоректно")
    @NotBlank(message = "Поле email не может быть пустым")
    private String email;
    private String activationCode;

    private String name;
    private String number;
    private String photoOsago;
    private String photo;


    @ElementCollection(targetClass = Role.class, fetch = FetchType.EAGER)
    @CollectionTable(name = "user_role", joinColumns = @JoinColumn(name = "user_id"))
    @Enumerated(EnumType.STRING)
    private Set<Role> roles;

    public boolean checkDate(){
        if((name == null) || (number == null) || (photo == null) || (photoOsago == null))
        {
            return false;
        }
        else {
            return true;
        }
    }

    public boolean checkName(){
        if(name == null){
           return false;
        }
        else {
            return true;
        }
    }

    public boolean checkNumber(){
        if(number == null){
            return false;
        }
        else {
            return true;
        }
    }

    public boolean isAdmin(){
        return roles.contains(Role.ADMIN);
    }

    public boolean isWatchman(){
        return roles.contains(Role.WATCHMAN);
    }

    public boolean isFullUser(){
        return roles.contains(Role.FULL_USER);
    }

    public boolean isUser(){
        return roles.contains(Role.USER);
    }

    public boolean haveNew(String username, String email, String name, String number){
        if(this.name == null){
            this.name = "";
        }
        if(this.number == null){
            this.number = "";
        }
        if((this.name.equals(name)) && (this.username.equals(username)) && (this.email.equals(email)) && (this.number.equals(number)))
        {
            return false;
        }
        else {
            return true;
        }
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return isActive();
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return getRoles();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getActivationCode() {
        return activationCode;
    }

    public void setActivationCode(String activateCode) {
        this.activationCode = activateCode;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhotoOsago() {
        return photoOsago;
    }

    public void setPhotoOsago(String photoOsago) {
        this.photoOsago = photoOsago;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }
}
