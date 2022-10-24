<#macro login path>
    <#if Session?? && Session.SPRING_SECURITY_LAST_EXCEPTION??>
        <div class="alert alert-danger" role="alert">
           ${Session.SPRING_SECURITY_LAST_EXCEPTION.message}
        </div>
    </#if>
    <#if message??>
        <div class="${messageType}" role="alert">
            ${message}
        </div>
    </#if>
<form action="${path}" method="post">
    <div class="form-group">
        <label class="col-sm-2 col-form-label"> Логин : </label>
        <div class="col-sm-6">
        <input type="text" name="username" value="<#if user??>${user.username}</#if>"
               class="form-control ${(usernameError??)?string('is-invalid', '')}"
               placeholder="User name"/>
            <#if usernameError??>
                <div class = "invalid-feedback">
                    ${usernameError}
                </div>
            </#if>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 col-form-label"> Пароль : </label>
        <div class="col-sm-6">
            <input type="password" name="password"
                   class="form-control ${(passwordError??)?string('is-invalid', '')}"
                   placeholder="Password"/>
            <#if passwordError??>
                <div class = "invalid-feedback">
                    ${passwordError}
                </div>
            </#if>
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