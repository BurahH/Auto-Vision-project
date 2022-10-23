<#import "parts/common.ftlh" as common>

<@common.page>
    <td><a href="/main">Назад</a> </td>
    <h2>Список пользователей</h2>

    <table class="table">
        <thead>
        <tr>
            <th scope="col">Имя</th>
            <th scope="col">Роль</th>
            <th scope="col">Ссылка на редактирование</th>
        </tr>
        </thead>
        <tbody>
        <#list users as user>
            <tr>
                <td>${user.username}</td>
                <td><#list user.roles as role>${role}<#sep>, </#list></td>
                <td><a href="/user/${user.id}">Редактировать</a> </td>
            </tr>
        </#list>
        </tbody>
    </table>
</@common.page>