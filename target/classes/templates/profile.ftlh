<#include "parts/securuty.ftlh">
<#import "parts/commonNew.ftlh" as common>

<@common.page>
    <link rel="stylesheet" href="../static/carCheckEdit.css" type="text/css">
    <script src="https://snipp.ru/cdn/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://snipp.ru/cdn/maskedinput/jquery.maskedinput.min.js"></script>
            <div class="row">
                <div class="col-lg-3">
                    <div class="card mb-3">
                        <div class="card-body text-center">
                            <#if user.photo??>
                            <img src="/img/${user.photo}" alt="avatar" class="rounded-circle img-fluid" style="width: 150px;height: 150px;">
                                <#else>
                                    <img src="/img/photostandart.png" alt="avatar" class="rounded-circle img-fluid" style="width: 150px;height: 150px;">
                            </#if>
                            <div class="col-sm-51">${user.username}</div>
                            <#if isFullUser>
                                <p class="text-success">Профиль подтвержден</p>
                                <#elseif isAdmin>
                                <p class="text-success">Профиль подтвержден</p>
                                <#elseif isWatchman>
                                <p class="text-success">Профиль подтвержден</p>
                                <#else>
                                <p class="text-danger">Профиль не верифицирован</p>
                            </#if>
                            <div class="d-flex justify-content-center mb-2">
                                <button type="button" class="btn btnp" onclick="window.location.href = '/profile/security'">Безопасность</button>
                            </div>
                            <div class="d-flex justify-content-center mb-2">
                                <button type="button" class="btn btn-outline-secondary btnl" onclick="window.location.href = '/profile/edit'">Редактировать профиль</button>
                            </div>
                        </div>
                    </div>

                    <div>
                        <div class="card-body p-0">
                            <a class="btn btnsp2" data-toggle="collapse" href="#multiCollapseExample1" role="button" aria-expanded="false" aria-controls="multiCollapseExample1">Полис ОСАГО</a>
                        </div>
                    </div>
                    <div class="collapse" id="multiCollapseExample1">
                        <div class="card">
                            <#if user.photoOsago??>
                            <img src="/img/${user.photoOsago}" alt="osago" class="rounded mx-auto d-block" style="width: 250px;height: 350px;">
                                <#else>
                                    <img src="/img/documentstandart.png" alt="osago" class="rounded mx-auto d-block" style="width: 250px;height: 350px;">
                            </#if>
                        </div>
                    </div>

                </div>
                <div class="col-lg-8">
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-21">
                                    <p class="mb-0">Email</p>
                                </div>
                                <div class="col-sm-6 text-end col-sm-621">
                                    <p class="text-end text-muted mb-0">${user.email}</p>
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-21">
                                    <p class="mb-0">ФИО</p>
                                </div>
                                <div class="col-sm-6 text-end col-sm-621">
                                    <#if user.name??>
                                        <p class="text-end text-muted mb-0">${user.name}</p>
                                    <#else>
                                        <p class="text-end text-muted mb-0">Отсутствует</p>
                                    </#if>
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-21">
                                    <p class="mb-0">Номер телефона</p>
                                </div>
                                <div class="col-sm-6 text-end col-sm-621">
                                    <#if user.name??>
                                        <p class="text-end text-muted mb-0">${user.number}</p>
                                    <#else>
                                        <p class="text-end text-muted mb-0">Отсутствует</p>
                                    </#if>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br>
                    <div class="col-lg-16">
                        <div class="card">
                            <div class="card-body">
                                <div class="title3">Автомобили</div>
                                <div class="row">
                                    <div class="col-sm-52">
                                        <p class="text-muted mb-0">Модель автомобиля</p>
                                    </div>
                                    <div class="col-sm-52">
                                        <p class="text-muted mb-0">Номер автомобиля</p>
                                    </div>
                                    <div class="col-sm-52">
                                        <p class="text-muted mb-0">VIN номер</p>
                                    </div>
                                    <div class="col-sm-52">
                                        <p class="text-muted mb-0">Статус</p>
                                    </div>
                                    <div class="col-sm-52">
                                        <p class="text-muted mb-0">Изменить</p>
                                    </div>
                                </div>
                                <hr>
                                <#if car??>
                                    <#list car as cars>
                                        <div class="row">
                                            <div class="col-sm-53">
                                                <p class="text-muted mb-0">${cars.model}</p>
                                            </div>
                                            <div class="col-sm-53">
                                                <p class="text-muted mb-0">${cars.number}</p>
                                            </div>
                                            <div class="col-sm-53">
                                                <p class="text-muted mb-0">${cars.vin}</p>
                                            </div>
                                            <#if cars.active>
                                            <div class="col-sm-533">
                                                <p class="text-success mb-0">Подтвержден</p>
                                            </div>
                                                <#else>
                                                    <div class="col-sm-533">
                                                        <p class="text-danger mb-0">Проверка</p>
                                                    </div>
                                            </#if>
                                            <div class="col-sm-2">
                                                <a class="table-hr" href="/profile/car/${cars.id}">Edit</a>
                                            </div>
                                        </div>
                                         <hr>
                                    </#list>
                                </#if>
                                <div class="row">
                                    <div class="col">
                                        <button type="button" class="btn btnp" data-toggle="modal" data-target="#modal" onclick="mask()">
                                            Добавить автомобиль
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                </div>

    <div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="title3" id="exampleModalLabel">Добавить новый автомобиль</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="col-sm-31">
                    Пожалуйста введите модель автомобиля и его номер (После добавления необходимо дождаться подтверждения)
                    <form method="post" id="newCar" enctype="multipart/form-data">
                        <div class="form-group">
                            <label class="col-sm-21 col-form-label"> Модель: </label>
                            <div class="col-sm-6">
                                <input type="text" name="modelCar" class="form-control2" placeholder="Модель автомобиля" required/>
                                <div class="invalid-feedback">
                                    Поле Модель автомобиля не может быть пустым
                                </div>
                            </div>
                            <label class="col-sm-21 col-form-label"> Номер (Большими буквами): </label>
                            <div class="col-sm-6">
                                <input type="text" name="number" class="mask-car form-control2 text-uppercase" placeholder="A000AA102" required/>
                                <div class="invalid-feedback">
                                    Поле номер не может быть пустым
                                </div>
                            </div>
                            <label class="col-sm-21 col-form-label"> Vin номер: </label>
                            <div class="col-sm-6">
                                <input type="text" name="vin" class="form-control2 text-uppercase" placeholder="vin" required/>
                                <div class="invalid-feedback">
                                    Поле Vin номер не может быть пустым
                                </div>
                            </div>
                            <div class="form-group">
                            <label class="col-sm-21 col-form-label"> Фото СТС : </label>
                            <div class="col-sm-6">
                                <input type="file" name="sts" required>
                                <div class="invalid-feedback">
                                    Поле фото стс не может быть пустым
                                </div>
                            </div>
                            </div>
                        </div>
                        <input type="hidden" name="_csrf" value="${_csrf.token}" />
                        <div class="modal-footer">
                            <button type="button" class="btn btn-outline-secondary btnl" data-dismiss="modal">Отмена</button>
                            <button type="submit" class="btn btnp">Добавить</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script>
        $.mask.definitions['h'] = '[А-Я]';
        $('.mask-car').mask('h999hh99?9');
    </script>
    <script>
    function form_submit(){
        document.getElementById("newCar").submit(); }
    </script>
</@common.page>