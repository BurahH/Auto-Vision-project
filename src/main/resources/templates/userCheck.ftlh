<#import "parts/common.ftlh" as common>

<@common.page>
    <h2>Список пользователей требующих верификации</h2>
    <table class="table">
        <thead>
        <tr>
            <th scope="col">Логин</th>
            <th scope="col">Email</th>
            <th scope="col">Ссылка на редактирование</th>
        </tr>
        </thead>
        <tbody>
        <#list users as user>
            <tr>
                <td>${user.username}</td>
                <td>${user.email}</td>
                <td><a href="/checklist/${user.id}">Редактировать</a> </td>
            </tr>
        </#list>
        </tbody>
    </table>
</@common.page>