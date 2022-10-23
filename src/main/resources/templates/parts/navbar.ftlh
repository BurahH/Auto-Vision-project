<#include "securuty.ftlh">
<#import "login.ftlh" as login>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="/">Auto Vision</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="/">Главная</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="/main">Messages</a>
            </li>
            <#if isAdmin>
            <li class="nav-item active">
                <a class="nav-link" href="/user">Список пользователей</a>
            </li>
            </#if>
        </ul>
        <#if "${name}" != "unknown">
        <div class="navbar-text mr-3">${name}</div>
        <@login.logout />
        </#if>
    </div>
</nav>