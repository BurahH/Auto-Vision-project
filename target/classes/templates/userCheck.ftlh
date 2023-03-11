<#import "parts/commonNew.ftlh" as common>

<@common.page>
    <link rel="stylesheet" href="../static/carCheckEdit.css" type="text/css">
    <h2 class="title2">Список пользователей требующих верификации</h2>
    <div class="table-21">
    <table class="fl-table">
        <thead>
        <tr>
            <th scope="col">Логин</th>
            <th scope="col">Email</th>
            <th scope="col">Ссылка на верифицирование</th>
        </tr>
        </thead>
        <tbody>
        <#list users as user>
            <tr>
                <td>${user.username}</td>
                <td>${user.email}</td>
                <td><a class="table-hr" href="/checklist/${user.id}">Верифицировать</a> </td>
            </tr>
        </#list>
        </tbody>
    </table>
    </div>
</@common.page>