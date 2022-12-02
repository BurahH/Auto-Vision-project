<#import "parts/commonNew.ftlh" as common>

<@common.page>
<h2>Список автомобилей</h2>

<form method="get" action="/car" class="form-inline">
    <div class="form-group mx-sm-3 mb-2">
        <input type="text" name="filter" value="${filter!""}"
        class="form-control"
        placeholder="Поиск по номеру/модели"/>
    </div>
    <button type="submit" class="btn btn-primary mb-2 pull-right">Найти</button>
</form>

<table class="table">
    <thead>
    <tr>
        <th scope="col">Пользователь</th>
        <th scope="col">Модель</th>
        <th scope="col">Номер</th>
        <th scope="col">Ссылка на редактирование</th>
    </tr>
    </thead>
    <tbody>
    <#list cars as car>
    <tr>
        <td><a href="/user/${car.user.id}">${car.user.username}</a> </td>
        <td>${car.model}</td>
        <td>${car.number}</td>
        <td><a href="/car/${car.id}">Редактировать</a> </td>
    </tr>
    </#list>
    </tbody>
</table>
</@common.page>