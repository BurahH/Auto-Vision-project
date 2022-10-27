<#import "parts/common.ftlh" as common>

<@common.page>
    <#if message??>
        <div class="${classInscription}" role="alert">
            ${message}
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </#if>

    <script>
        function resetLogin(){
            document.getElementById("Login").value = "";
        }
    </script>
   <h2>Редактировать пользователя</h2>

    <form action="/user" method="post">
        <div class="form-group">
            <label class="col-sm-2 col-form-label"> E-mail : </label>
            <div class="col-sm-6">
                <input type="text" name="email" class="form-control" value="${user.email}"/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 col-form-label"> Логин : </label>
            <div class="col-sm-6">
                <input type="text" name="username" class="form-control" value="${user.username}"/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 col-form-label"> Пароль : </label>
            <div class="col-sm-6">
                <input type="text" name="password" class="form-control" placeholder="Password"/>
            </div>
        </div>
        <#list roles as role>
            <div>
                <label><input type="checkbox" name="${role}" ${user.roles?seq_contains(role)?string("checked", "")}>${role}</label>
            </div>
        </#list>
        <p>
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal">
            Удалить пользователя
        </button>
        </p>

        <div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Удалить пользователя</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="resetLogin()">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Вы уверены? Это действие нельзя отменить.
                        Для подтверждения удаления введите логин пользователя.
                            <div class="form-group">
                                <label class="col-sm-2 col-form-label"> Логин: </label>
                                <div class="col-sm-6">
                                    <input type="username" name="adminLogin" class="form-control" placeholder="login" id="Login" required/>
                                </div>
                            </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="resetLogin()">Отмена</button>
                        <button type="submit" class="btn btn-primary">Удалить</button>
                    </div>
                </div>
            </div>
        </div>

        <input type="hidden" value="${user.id}" name="userId">
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit" class="btn btn-primary mb-2">Сохранить</button>
    </form>
    <a class="btn btn-light" href="/user" role="button">Назад</a>
</@common.page>