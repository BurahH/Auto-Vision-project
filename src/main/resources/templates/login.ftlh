<#import "parts/commonNew.ftlh" as common>
<#import "parts/login.ftlh" as login>

<@common.page>
    <h2>Вход</h2>
<@login.login "/login" />
<a href="/registration">Нет аккаунта?</a>
    <a href="/recovery">Забыли пароль?</a>
</@common.page>