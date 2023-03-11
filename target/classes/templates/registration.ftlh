<#import "parts/commonNew.ftlh" as common>
<#import "parts/login.ftlh" as login>

<@common.page>
    <script src="/static/checkValidate.js"></script>
    <div class="title2">Регистрация</div>
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
            <label class="col-sm-21 col-form-label"> E-mail : </label>
            <div class="col-sm-6">
                <input type="email" name="email" value="<#if user??>${user.email}</#if> "
                       class="form-control4 ${(emailError??)?string('is-invalid', '')}"
                       placeholder="E-mail"/>
                <#if emailError??>
                    <div class = "is-invalid text-danger">
                        ${emailError}
                    </div>
                </#if>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-21 col-form-label"> Логин : </label>
            <div class="col-sm-6">
                <input type="text" name="username" value="<#if user??>${user.username}</#if>"
                       class="form-control4 ${(usernameError??)?string('is-invalid', '')}"
                       placeholder="User name"/>
                <#if usernameError??>
                    <div class = "is-invalid text-danger">
                        ${usernameError}
                    </div>
                </#if>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-21 col-form-label"> Пароль : </label>
            <div class="col-sm-6">
                <input type="password" name="password"
                       class="form-control4 ${(passwordError??)?string('is-invalid', '')}"
                       placeholder="Password"/>
                <#if passwordError??>
                    <div class = "is-invalid text-danger">
                        ${passwordError}
                    </div>
                </#if>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-21 col-form-label"> Повторите пароль : </label>
            <div class="col-sm-6">
                <input type="password" name="repeatPassword"
                       class="form-control4 ${(repeatPasswordError??)?string('is-invalid', '')}"
                       placeholder="Repeat password"/>
                <#if repeatPasswordError??>
                    <div class = "is-invalid text-danger">
                        ${repeatPasswordError}
                    </div>
                </#if>
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit" class="btn btnp">Зарегистрироваться</button>
        <a class="btn btn-outline-secondary btnl" href="/login" role="button">Назад</a>
    </form>
</@common.page>