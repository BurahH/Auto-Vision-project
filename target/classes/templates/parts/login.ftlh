<#macro login path>
    <#if message??>
        <div class="alert alert-success" role="alert">
            ${message}
        </div>
    </#if>
<form action="${path}" method="post">
    <div class="form-group">
        <label class="col-sm-2 col-form-label"> Логин : </label>
        <div class="col-sm-6">
        <input type="text" name="username" class="form-control" placeholder="User name"/>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 col-form-label"> Пароль : </label>
        <div class="col-sm-6">
            <input type="password" name="password" class="form-control" placeholder="Password"/>
        </div>
    </div>
    <input type="hidden" name="_csrf" value="${_csrf.token}" />
    <button type="submit" class="btn btn-primary mb-2">Войти</button>
</form>
</#macro>

<#macro logout>
<form action="/logout" method="post">
    <input type="hidden" name="_csrf" value="${_csrf.token}" />
    <button type="submit" class="btn btn-primary mb-2">Выйти</button>
</form>
</#macro>