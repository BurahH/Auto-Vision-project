<#import "parts/common.ftlh" as common>
<#import "parts/login.ftlh" as login>

<@common.page>
    <h2>Регистрация</h2>
    <#if message??>
    <div class="alert alert-danger" role="alert">
        ${message}
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    </#if>
    <form action="/registration" method="post">
        <div class="form-group">
            <label class="col-sm-2 col-form-label"> E-mail : </label>
            <div class="col-sm-6">
                <input type="email" name="email" value="<#if user??>${user.email}</#if> "
                       class="form-control ${(emailError??)?string('is-invalid', '')}"
                       placeholder="E-mail"/>
                <#if emailError??>
                    <div class = "invalid-feedback">
                        ${emailError}
                    </div>
                </#if>
            </div>
        </div>
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
        <div class="form-group">
            <label class="col-sm-2 col-form-label"> Повторите пароль : </label>
            <div class="col-sm-6">
                <input type="password" name="repeatPassword"
                       class="form-control ${(repeatPasswordError??)?string('is-invalid', '')}"
                       placeholder="Repeat password"/>
                <#if repeatPasswordError??>
                    <div class = "invalid-feedback">
                        ${repeatPasswordError}
                    </div>
                </#if>
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit" class="btn btn-primary mb-2">Зарегистрироваться</button>
    </form>
    <a class="btn btn-light" href="/login" role="button">Назад</a>
</@common.page>