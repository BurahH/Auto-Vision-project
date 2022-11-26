<#include "securuty.ftlh">
<#import "login.ftlh" as login>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="/">Auto Vision</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <!--<li class="nav-item active">
                <a class="nav-link" href="/main">Messages</a>
            </li> -->
            <#if isAdmin>
            <li class="nav-item active">
                <a class="nav-link" href="/user">Список пользователей</a>
            </li>
            </#if>
            <#if isAdmin>
                <li class="nav-item active">
                    <a class="nav-link" href="/">Редактировать цену</a>
                </li>
            </#if>
            <#if isWatchman>
                <li class="nav-item active">
                    <a class="nav-link" href="/checklist">Верификация пользователей</a>
                </li>
            </#if>
            <#if isWatchman>
                <li class="nav-item active">
                    <a class="nav-link" href="/">База номеров</a>
                </li>
            </#if>
            <#if isUser>
                <li class="nav-item active">
                    <a class="nav-link" href="/">Парковка</a>
                </li>
            </#if>
        </ul>
        <#if "${name}" != "unknown">
            <a class="nav-link mr-3" href="/profile" role="button">${name}</a>
        <@login.logout />
            <#else >
            <a class="nav-link mr-3" href="/login" role="button">Вход</a>
        </#if>
    </div>
</nav>