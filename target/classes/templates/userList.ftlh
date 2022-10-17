<#import "parts/common.ftlh" as common>

<@common.page>
    <td><a href="/main">Назад</a> </td>
    <h2>Список пользователей</h2>

    <table>
        <thead>
        <tr>
            <th>Name</th>
            <th>Role</th>
            <th></th>
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