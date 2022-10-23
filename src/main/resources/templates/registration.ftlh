<#import "parts/common.ftlh" as common>
<#import "parts/login.ftlh" as login>

<@common.page>
    <h2>Регистрация</h2>
    <#if message??>
    <div class="alert alert-danger" role="alert">
        ${message}
    </div>
    </#if>
    <form action="/registration" method="post">
        <div class="form-group">
            <label class="col-sm-2 col-form-label"> E-mail : </label>
            <div class="col-sm-6">
                <input type="email" name="email" class="form-control" placeholder="E-mail"/>
            </div>
        </div>
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
        <div class="form-group">
            <label class="col-sm-2 col-form-label"> Повторите пароль : </label>
            <div class="col-sm-6">
                <input type="password" name="repeatpassword" class="form-control" placeholder="Repeat password"/>
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit" class="btn btn-primary mb-2">Зарегистрироваться</button>
    </form>
    <a class="btn btn-light" href="/login" role="button">Назад</a>
</@common.page>