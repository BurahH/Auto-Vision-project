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
    <h2>Редактировать автомобиль</h2>

    <form action="/car" method="post" id="editUser" enctype="multipart/form-data">
        <div class="form-group">
            <label class="col-sm-3 col-form-label"> Логин : </label>
            <div class="col-sm-6">
                <p class="text-muted mb-0">${car.user.username}</p>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 col-form-label"> ФИО пользователя : </label>
            <div class="col-sm-6">
                <p class="text-muted mb-0"><#if car.user.name??>${car.user.name}</#if></p>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 col-form-label"> Модель автомобиля : </label>
            <div class="col-sm-6">
                <input type="text" name="modelCar" class="form-control" value="${car.model}"/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 col-form-label"> Номер автомобиля : </label>
            <div class="col-sm-6">
                <input type="text" name="number" class="form-control" value="${car.number}"/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 col-form-label"> VIN автомобиля : </label>
            <div class="col-sm-6">
                <input type="text" name="vin" class="form-control" value="${car.vin}"/>
            </div>
        </div>

        <div class="card mb-8 mb-lg-0">
            <div class="card-body p-0">
                <a class="btn btn-link btn-block text-left" data-toggle="collapse" href="#multiCollapseExample1" role="button" aria-expanded="false" aria-controls="multiCollapseExample1">Полис ОСАГО пользователя</a>
            </div>
        </div>
        <div class="collapse multi-collapse card mb-8 mb-lg-0" id="multiCollapseExample1">
            <div class="card-body p-0">
                <img src="/img/<#if car.user.photoOsago??>${car.user.photoOsago}<#else>documentstandart.png</#if>" alt="osago" class="rounded mx-auto d-block" style="width: 600px;height: 600px;">
            </div>
        </div>

        <div class="card mb-8 mb-lg-0">
            <div class="card-body p-0">
                <a class="btn btn-link btn-block text-left" data-toggle="collapse" href="#multiCollapseExample2" role="button" aria-expanded="false" aria-controls="multiCollapseExample1">СТС автомобиля</a>
            </div>
        </div>
        <div class="collapse multi-collapse card mb-8 mb-lg-0" id="multiCollapseExample2">
            <div class="card-body p-0">
                <img src="/img/${car.sts}" alt="osago" class="rounded mx-auto d-block" style="width: 600px;height: 600px;">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 col-form-label"> Изменить фото СТС : </label>
            <div class="col-sm-6">
                <input type="file" name="sts">
            </div>

        <div>
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal">
                Удалить автомобиль
            </button>
        </div>

        <div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Удалить автомобиль</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="resetLogin()">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Вы уверены? Это действие нельзя отменить. Для подтверждения удаления введите номер автомобиля.
                        <div class="form-group">
                            <label class="col-sm-2 col-form-label"> Номер: </label>
                            <div class="col-sm-6">
                                <input type="text" name="numberCar" class="form-control" placeholder="Номер" id="Login" required/>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="resetLogin()">Отмена</button>
                        <button type="submit" class="btn btn-primary" name="delete">Удалить</button>
                    </div>
                </div>
            </div>
        </div>

        <input type="hidden" value="${car.id}" name="carId">
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit" class="btn btn-primary mb-2" onclick="form_submit()">Сохранить</button>
    </form>
    <a class="btn btn-light" href="/car" role="button">Назад</a>

    <script>
        function resetLogin(){
            document.getElementById("Login").value = "";
        }
        function form_submit() {
            document.getElementById("editUser").submit();
        }
    </script>

</@common.page>