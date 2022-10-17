<#import "parts/common.ftlh" as common>
<#import "parts/login.ftlh" as login>

<@common.page>
    <h2>Add new user</h2>
    ${message!""}
    <form action=/registration method="post">
        <div><label> Имя пользователя : <input type="text" name="username"/> </label></div>
        <div><label> Пароль: <input type="password" name="password"/> </label></div>
        <div><label> Повторите пароль: <input type="password" name="repeatpassword"/> </label></div>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <div><input type="submit" value="Registartion"/></div>
    </form>
</@common.page>