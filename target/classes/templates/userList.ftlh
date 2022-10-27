<#import "parts/common.ftlh" as common>

<@common.page>
    <h2>Список пользователей</h2>

    <form method="get" action="/user" class="form-inline">
        <div class="form-group mx-sm-3 mb-2">
            <input type="text" name="filter" value="${filter!""}"
                   class="form-control"
                   placeholder="Поиск по логину/почте"/>
        </div>
        <button type="submit" class="btn btn-primary mb-2 pull-right">Найти</button>
    </form>

    <table class="table">
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
                <td><a href="/user/${user.id}">Редактировать</a> </td>
            </tr>
        </#list>
            </tbody>
            </table>
</@common.page>