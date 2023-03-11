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
    <div class="title2">Востановление пароля</div>
    <form action="/recovery" method="post">
        <div class="form-group">
            <div class="col-sm-21 col-form-label"> E-mail : </div>
            <div class="col-sm-6">
                <input type="email" name="email" value="" class="form-control2" placeholder="E-mail" required/>
            </div>
        </div>
        
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit" class="btn btnp">Востановить</button>
        <a class="btn btn-outline-secondary btnl" href="/login" role="button">Назад</a>
    </form>
</@common.page>