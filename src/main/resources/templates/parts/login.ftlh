<#macro login path>

    <script src="/static/checkValidate.js"></script>

    <#if errorAuth??>
        <div class="alert alert-danger" role="alert" id="div1">
           ${errorAuth}
            <button type="button" class="close" data-dismiss="alert" aria-label="Close" onclick="window.location.href = '/login'">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </#if>
    <#if message??>
        <div class="${messageType}" role="alert">
            ${message}
            <button type="button" class="close" data-dismiss="alert" aria-label="Close" onclick="closeAlert()">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </#if>
<form action="${path}" method="post" class= "needs-validation" novalidate>
    <div class="form-group">
        <label class="col-sm-2 col-form-label"> Логин : </label>
        <div class="col-sm-6">
        <input type="text" name="username" value="<#if user??>${user.username}</#if>"
               class="form-control"
               placeholder="User name" id="username" required/>
            <div class="invalid-feedback">
                Поле логин не может быть пустым
            </div>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 col-form-label"> Пароль : </label>
        <div class="col-sm-6">
            <input type="password" name="password"
                   class="form-control"
                   placeholder="Password" id="password" required/>
            <div class="invalid-feedback">
                Поле пароль не может быть пустым
            </div>
        </div>
    </div>
    <input type="hidden" name="_csrf" value="${_csrf.token}" />
    <div class="col-12">
        <button type="submit" class="btn btn-primary mb-2" onclick="checkValidation()">Войти</button>
    </div>
</form>
    <remove var = "SPRING_SECURITY_LAST_EXCEPTION" scope = "session" />
</#macro>

<#macro logout>
<form action="/logout" method="post">
    <input type="hidden" name="_csrf" value="${_csrf.token}" />
    <button type="submit" class="btn btn-primary mb-2">Выйти</button>
</form>
</#macro>