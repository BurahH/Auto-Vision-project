<#import "parts/commonNew.ftlh" as common>

<@common.page>
    <link rel="stylesheet" href="../static/carCheckEdit.css" type="text/css">
<div class="title2">Список автомобилей</div>

<form method="get" action="/car" class="form-inline">
    <div class="form-group">
        <input type="text" name="filter" value="${filter!""}"
        class="form-control22"
        placeholder="Поиск по номеру/модели"/>
    </div>
    <button type="submit" class="btn btnp2">Найти</button>
</form>
<div class="table-21">
    <table class="fl-table">
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
            <td><a class="table-hr" href="/user/${car.user.id}">${car.user.username}</a> </td>
            <td>${car.model}</td>
            <td>${car.number}</td>
            <td><a class="table-hr" href="/car/${car.id}">Редактировать</a> </td>
        </tr>
        </#list>
        </tbody>
    </table>
</div>
</@common.page>