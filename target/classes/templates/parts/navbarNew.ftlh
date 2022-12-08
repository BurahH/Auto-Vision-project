<#include "securuty.ftlh">
<#import "login.ftlh" as login>

<div class="header">
    <div class="container">
        <div class="header_line">
            <div class="header_logo">
                <img src="../../img/image/logo.png" alt="">
            </div>

            <#if isUser>
            <div class="menu">
                <a class="menu_item1" href="/">Главная</a>
                <a class="menu_item2" href="/view">Парковка</a>
            </div>
            </#if>

            <#if isAdmin>
                <div class="menu">
                    <a class="menu_item1-2" href="/user">Пользователи</a>
                    <a class="menu_item2-2" href="/car">Автомобили</a>
                    <a class="menu_item3-2" href="/parking">Парковка</a>
                </div>
            </#if>

            <#if isWatchman>
                <div class="menu">
                    <a class="menu_item1-3" href="/">Камеры</a>
                    <a class="menu_item2-3" href="/checklist">Верификация пользователей</a>
                    <a class="menu_item3-3" href="/checklist/carlist">Верификация автомобилей</a>
                </div>
            </#if>

            <#if "${name}" = "unknown">
                <div class="menu">
                </div>
            </#if>

            <div class="phone">
                <div class="number">+0 (123) 456-78-90</div>
                <div class="phone_img">
                    <img src="../../img/image/Phone.png" alt="">
                </div>
            </div>

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