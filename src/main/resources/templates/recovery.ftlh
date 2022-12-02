<#import "parts/commonNew.ftlh" as common>
<#import "parts/login.ftlh" as login>

<@common.page>
    <#if message??>
        <div class="${classInscription}" role="alert">
            ${message}
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </#if>
    <h2>Востановление пароля</h2>
    <form action="/recovery" method="post">
        <div class="form-group">
            <label class="col-sm-2 col-form-label"> E-mail : </label>
            <div class="col-sm-6">
                <input type="email" name="email" value="" class="form-control" placeholder="E-mail" required/>
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit" class="btn btn-primary mb-2">Востановить</button>
    </form>
    <a class="btn btn-light" href="/login" role="button">Назад</a>
</@common.page>