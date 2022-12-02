<#import "parts/commonNew.ftlh" as common>

<@common.page>
    <h2>Список автомобилей требующих верификации</h2>
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
                <#if car.user.name??>
                <td>${car.user.name}</td>
                    <#else>
                    <td>Пользователь не ввел личные данные</td>
                </#if>
                <td>${car.model}</td>
                <td>${car.number}</td>
                <td><a href="/checklist/carlist/${car.id}">Редактировать</a> </td>
            </tr>
        </#list>
        </tbody>
    </table>
</@common.page>