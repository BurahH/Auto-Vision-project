<#import "parts/common.ftlh" as common>

<@common.page>
    <#if message??>
        <div class="${classInscription}" role="alert">
            ${message}
        </div>
    </#if>
   <h2>Редактировать пользователя</h2>

    <form action="/user" method="post">
        <div class="form-group">
            <label class="col-sm-2 col-form-label"> E-mail : </label>
            <div class="col-sm-6">
                <input type="text" name="email" class="form-control" value="${user.email}"/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 col-form-label"> Логин : </label>
            <div class="col-sm-6">
                <input type="text" name="username" class="form-control" value="${user.username}"/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 col-form-label"> Пароль : </label>
            <div class="col-sm-6">
                <input type="text" name="password" class="form-control" placeholder="Password"/>
            </div>
        </div>
        <#list roles as role>
            <div>
                <label><input type="checkbox" name="${role}" ${user.roles?seq_contains(role)?string("checked", "")}>${role}</label>
            </div>
        </#list>
        <input type="hidden" value="${user.id}" name="userId">
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit" class="btn btn-primary mb-2">Сохранить</button>
    </form>
    <a class="btn btn-light" href="/user" role="button">Назад</a>
</@common.page>