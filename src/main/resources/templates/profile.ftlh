<#import "parts/common.ftlh" as common>
<#import "parts/login.ftlh" as login>

<@common.page>
    <h2>${username}</h2>
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
    </form>
</@common.page>