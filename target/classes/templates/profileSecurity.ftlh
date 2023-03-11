<#import "parts/commonNew.ftlh" as common>
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
    <div class="title2">Безопасность</div>
    <form method="post">
    <div class="form-group">
        <div class="col-sm-21 col-form-label"> E-mail : </div>
        <div class="col-sm-6">
            <input type="email" name="email" class="form-control2" value="${email}" required/>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-21 col-form-label"> Пароль : </div>
        <div class="col-sm-6">
            <input type="password" name="password" class="form-control2" placeholder="Password"/>
        </div>
    </div>
    <input type="hidden" name="_csrf" value="${_csrf.token}" />
    <button type="submit" class="btn btnp">Сохранить</button>
        <a class="btn btn-outline-secondary btnl" href="/profile" role="button">Назад</a>
    </form>
</@common.page>