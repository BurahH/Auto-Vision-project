<#import "parts/commonNew.ftlh" as common>

<@common.page>
    <link rel="stylesheet" href="../static/carCheckEdit.css" type="text/css">
    <div class="title2">Список автомобилей требующих верификации</div>
    <div class="table-21">
    <table class="fl-table">
        <thead>
        <tr>
            <th scope="col">Пользователь</th>
            <th scope="col">Модель</th>
            <th scope="col">Номер</th>
            <th scope="col">Ссылка на верификацию</th>
        </tr>
        </thead>
        <tbody>
        <#list cars as car>
            <tr>
                <#if car.user.name??>
                    <#if car.user.name = "">
                        <td>Пользователь не ввел личные данные</td>
                        <#else>
                        <td>${car.user.name}</td>
                    </#if>
                    <#else>
                        <td>Пользователь не ввел личные данные</td>
                </#if>
                <td>${car.model}</td>
                <td>${car.number}</td>
                <td><a class="table-hr" href="/checklist/carlist/${car.id}">Верифицировать</a> </td>
            </tr>
        </#list>
        </tbody>
    </table>
    </div>
</@common.page>