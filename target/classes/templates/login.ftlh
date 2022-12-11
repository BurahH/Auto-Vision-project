<#import "parts/commonNew.ftlh" as common>

<@common.page>
<link rel="stylesheet" href="../static/LoginStyle.css" type="text/css">
<script src="/static/checkValidate.js"></script>

    <#if errorAuth??>
    <#if Session?? && Session.SPRING_SECURITY_LAST_EXCEPTION??>
        <div class="row">
            <div class="col-md-7 offset-md-5">
                <div class="alert alert-danger" role="alert" id="div1">
                    <#if Session.SPRING_SECURITY_LAST_EXCEPTION.message = "Bad credentials">
                        Неверный логин или пароль
                    <#else>
                        Для входа активируйте аккаунт, перейдя по ссылке в письме
                    </#if>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close" onclick="closeAlert()">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            </div>
        </div>
    </#if>
    </#if>
<#if message??>
    <div class="row">
        <div class="col-md-7 offset-md-5">
    <div class="${messageType}" role="alert">
        ${message}
        <button type="button" class="close" data-dismiss="alert" aria-label="Close" onclick="closeAlert()">
            <span aria-hidden="true">&times;</span>
        </button>
            </div>
        </div>
    </div>
</#if>
    <div class="title">Вход</div>
<form action="/login" method="post" class= "needs-validation" novalidate>
    <div class="signup">
        <div class="login-txt">Логин</div>
        <div class="form-field1">
                <input class="form-field1-input form-control" type="text" placeholder="login" name="username" id="username" required>
                <div class="invalid-feedback invalid-1">
                    Поле логин не может быть пустым
                </div>
        </div>
        
        <div class="password-txt">Пароль</div>
        <div class="form-field2">
                <input class="form-field2-input form-control" type="password" placeholder="password" name="password" id="password" required>
            <div class="invalid-feedback invalid-2">
                Поле пароль не может быть пустым
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        
        <button class="btn1"  type="submit" onclick="checkValidation()">ВОЙТИ</button>
    </div>
</form>
    <div class="strip"></div>
    
    <a class="frgt" href="/recovery">Забыли свой пароль?</a>
    
    <div class="reg">
        <label for="registration" class="first">Если вы впервые на сайте, заполните, пожалуйста, регистрационную форму.</label>
        <a href="/registration" class="registration">Зарегистрироваться</a>
    </div>
</@common.page>

    







