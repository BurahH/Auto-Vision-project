<#include "securuty.ftlh">
<#import "login.ftlh" as login>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <img class="navbar-brand" src="../../img/image/logo.png" alt="">
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
<div class="collapse navbar-collapse" id="navbarSupportedContent">
<div class="header">
    <div class="container">
        <div class="header_line">
            <ul class="navbar-nav mr-auto">
            <#if isUser>
                <li class="nav-item active">
                    <a class="nav-link menu_item1" href="/">Главная</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link menu_item2" href="/view">Парковка</a>
                </li>
            </#if>

            <#if isAdmin>
                <li class="nav-item active">
                    <a class="nav-link menu_item1-2" href="/user">Пользователи</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link menu_item2-2" href="/car">Автомобили</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link menu_item3-2" href="/parking">Парковка</a>
                </li>
            </#if>

            <#if isWatchman>
                <li class="nav-item active">
                    <a class="nav-link menu_item1-3" href="/">Камеры</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link menu_item2-3" href="/checklist">Верификация пользователей</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link menu_item3-3" href="/checklist/carlist">Верификация автомобилей</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link menu_item3-3" href="/checkAuto">Пропуск автомобилей</a>
                </li>
            </#if>

            <#if "${name}" = "unknown">
                <div class="menu">
                </div>
            </#if>
        </div>
</nav>

            <div class="phone">
                <div class="number">+0 (123) 456-78-90</div>
                <div class="phone_img">
                    <img src="../../img/image/Phone.png" alt="">
                </div>
            </div>
            </ul>

            <#if "${name}" != "unknown">
            <div class="LK">
                    <button class="btn dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                        <img src="../../img/image/LK.png" alt="">
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                        <li><a class="dropdown-item" href="/profile">Профиль</a></li>
                        <form action="/logout" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}" />
                            <button type="submit" class="dropdown-item">Выйти</button>
                        </form>
                    </ul>
                </div>
            <#else>
                <div class="LK">
                    <button class="btn dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                        <img src="../../img/image/LK.png" alt="">
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                        <li><a class="dropdown-item" href="/login">Войти</a></li>
                    </ul>
                </div>
            </#if>

        </div>

    </div>
</div>
