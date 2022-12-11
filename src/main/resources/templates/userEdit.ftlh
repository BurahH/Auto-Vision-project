<#import "parts/commonNew.ftlh" as common>

<@common.page>
    <link rel="stylesheet" href="../static/carCheckEdit.css" type="text/css">
    <#if message??>
        <div class="${classInscription}" role="alert">
            ${message}
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </#if>
   <div class="title2">Редактировать пользователя</div>

    <form action="/user" method="post" id="editUser" enctype="multipart/form-data">
        <div class="form-group">
            <div class="col-sm-21 col-form-label"> E-mail : </div>
            <div class="col-sm-6">
                <input type="text" name="email" class="form-control4" value="${user.email}"/>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-21 col-form-label"> Логин : </div>
            <div class="col-sm-6">
                <input type="text" name="username" class="form-control4" value="${user.username}"/>
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-21 col-form-label"> ФИО : </div>
            <div class="col-sm-6">
                <input type="text" name="name" class="form-control4" value="<#if user.name??>${user.name}</#if>"/>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-21 col-form-label"> Номер телефона : </div>
            <div class="col-sm-6">
                <input type="text" name="number" class="form-control4" value="<#if user.number??>${user.number}</#if>"/>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-21 col-form-label"> Пароль : </div>
            <div class="col-sm-6">
                <input type="text" name="password" class="form-control4" placeholder="Password"/>
            </div>
        </div>

        <div>
            <div class="card-body p-0">
                <a class="btn btns" data-toggle="collapse" href="#multiCollapseExample1" role="button" aria-expanded="false" aria-controls="multiCollapseExample1">Полис ОСАГО</a>
            </div>
        </div>
        <div class="collapse" id="multiCollapseExample1">
            <div class="card card-body">
                <img src="/img/<#if user.photoOsago??>${user.photoOsago}<#else>documentstandart.png</#if>" alt="osago" class="rounded mx-auto d-block" style="width: 600px;height: 600px;">
            </div>
        </div>

        <div>
            <div class="card-body p-0">
                <a class="btn btns" data-toggle="collapse" href="#multiCollapseExample2" role="button" aria-expanded="false" aria-controls="multiCollapseExample1">Фото пользователя</a>
            </div>
        </div>
        <div class="collapse" id="multiCollapseExample2">
            <div class="card card-body">
                <img src="/img/<#if user.photo??>${user.photo}<#else>photostandart.png</#if>" alt="osago" class="rounded mx-auto d-block" style="width: 600px;height: 600px;">
            </div>
        </div>


        <div class="form-group">
            <div class="col-sm-21 col-form-label"> Изменить фото ОСАГО : </div>
            <div class="col-sm-6">
                <input type="file" name="photoOsago">
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-21 col-form-label"> Изменить фото : </div>
            <div class="col-sm-6">
                <input type="file" name="photo">
            </div>
        </div>





        <#list roles as role>
            <div>
                <label><input type="checkbox" name="${role}" ${user.roles?seq_contains(role)?string("checked", "")}>${role}</label>
            </div>
        </#list>



        <div>
        <button type="button" class="btn btnp3" data-toggle="modal" data-target="#modal">
            Удалить пользователя
        </button>
        </div>

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
                        Вы уверены? Это действие нельзя отменить. Для подтверждения удаления введите логин пользователя.
                        <div class="form-group">
                            <div class="col-sm-21 col-form-label"> Логин: </div>
                            <div class="col-sm-6">
                                <input type="username" name="adminLogin" class="form-control2" placeholder="login" id="Login" required/>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary btnl" data-dismiss="modal" onclick="resetLogin()">Отмена</button>
                        <button type="submit" class="btn btnp3" name="delete">Удалить</button>
                    </div>
                </div>
            </div>
        </div>

        <input type="hidden" value="${user.id}" name="userId">
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit" class="btn btnp3" onclick="form_submit()">Сохранить</button>
        <a class="btn btn-outline-secondary btnl" href="/user" role="button">Назад</a>
    </form>
    <script>
        function resetLogin(){
            document.getElementById("Login").value = "";
        }
        function form_submit() {
            document.getElementById("editUser").submit();
        }
    </script>
</@common.page>