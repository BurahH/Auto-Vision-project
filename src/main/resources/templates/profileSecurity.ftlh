<#import "parts/common.ftlh" as common>
<#import "parts/login.ftlh" as login>

<@common.page>
    <#if message??>
        <div class="alert alert-danger" role="alert">
            ${message}
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </#if>
    <h2>Безопасность</h2>
    <form method="post">
    <div class="form-group">
        <label class="col-sm-2 col-form-label"> E-mail : </label>
        <div class="col-sm-6">
            <input type="email" name="email" class="form-control" value="${email}"/>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 col-form-label"> Пароль : </label>
        <div class="col-sm-6">
            <input type="password" name="password" class="form-control" placeholder="Password"/>
        </div>
    </div>
    <input type="hidden" name="_csrf" value="${_csrf.token}" />
    <button type="submit" class="btn btn-primary mb-2">Сохранить</button>
        <a class="btn btn-light" href="/profile" role="button">Назад</a>
    </form>
</@common.page>