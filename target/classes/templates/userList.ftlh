<#import "parts/commonNew.ftlh" as common>

<@common.page>
    <link rel="stylesheet" href="../static/carCheckEdit.css" type="text/css">
    <div class="title2">Список пользователей</div>

    <form method="get" action="/user" class="form-inline">
        <div class="form-group mx-sm-3 mb-2">
            <input type="text" name="filter" value="${filter!""}"
                   class="form-control3"
                   placeholder="Поиск по логину/почте"/>
        </div>
        <button type="submit" class="btn btnp2">Найти</button>
    </form>
<div class="table-21">
    <table class="fl-table">
        <thead>
        <tr>
            <th scope="col">Имя</th>
            <th scope="col">Email</th>
            <th scope="col">Роль</th>
            <th scope="col">Ссылка на редактирование</th>
        </tr>
        </thead>
        <tbody>
        <#list users as user>
            <tr>
                <td>${user.username}</td>
                <td>${user.email}</td>
                <td><#list user.roles as role>${role}<#sep>, </#list></td>
                <td><a class="table-hr" href="/user/${user.id}">Редактировать</a> </td>
            </tr>
        </#list>
            </tbody>
            </table>
</div>
</@common.page>