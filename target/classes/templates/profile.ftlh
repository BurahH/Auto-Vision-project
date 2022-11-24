<#include "parts/securuty.ftlh">
<#import "parts/common.ftlh" as common>
<#import "parts/login.ftlh" as login>

<@common.page>
    <#if message??>
        <div class="alert alert-danger" role="alert">
            ${message}
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </#if>
    <script src="https://snipp.ru/cdn/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://snipp.ru/cdn/maskedinput/jquery.maskedinput.min.js"></script>
            <div class="row">
                <div class="col-lg-4">
                    <div class="card mb-4">
                        <div class="card-body text-center">
                            <#if user.photo??>
                            <img src="/img/${user.photo}" alt="avatar" class="rounded-circle img-fluid" style="width: 150px;">
                                <#else>
                                    <img src="/img/photostandart.png" alt="avatar" class="rounded-circle img-fluid" style="width: 150px;">
                            </#if>
                            <h5 class="my-3">${user.username}</h5>
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
                                <button type="button" class="btn btn-primary" onclick="window.location.href = '/profile/security'">Безопасность</button>
                            </div>
                            <div class="d-flex justify-content-center mb-2">
                                <button type="button" class="btn btn-outline-primary ms-1" onclick="window.location.href = '/profile/edit/'">Редактировать профиль</button>
                            </div>
                        </div>
                    </div>
                    <div class="card mb-4 mb-lg-0">
                        <div class="card-body p-0">
                            <#if user.photoOsago??>
                            <img src="/img/${user.photoOsago}" alt="osago" style="width: 250px;">
                                <#else>
                                    <img src="/img/documentstandart.png" alt="osago" class="rounded mx-auto d-block" style="width: 250px;">
                            </#if>
                        </div>
                    </div>
                </div>
                <div class="col-lg-8">
                    <div class="card mb-4">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-3">
                                    <p class="mb-0">Email</p>
                                </div>
                                <div class="col-sm-9">
                                    <p class="text-muted mb-0">${user.email}</p>
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <p class="mb-0">ФИО</p>
                                </div>
                                <div class="col-sm-9">
                                    <#if user.name??>
                                        <p class="text-muted mb-0">${user.name}</p>
                                    <#else>
                                        <p class="text-muted mb-0">Отсутствует</p>
                                    </#if>
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <p class="mb-0">Phone</p>
                                </div>
                                <div class="col-sm-9">
                                    <#if user.name??>
                                        <p class="text-muted mb-0">${user.phone}</p>
                                    <#else>
                                        <p class="text-muted mb-0">Отсутствует</p>
                                    </#if>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-15">
                        <div class="card mb-5">
                            <div class="card-body">
                                <h5 class="my-3">Автомобили</h5>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <p class="mb-0">Модель автомобиля</p>
                                    </div>
                                    <div class="col-sm-3">
                                        <p class="text-muted mb-0">Номер автомобиля</p>
                                    </div>
                                    <div class="col-sm-3">
                                        <p class="text-muted mb-0">Статус</p>
                                    </div>
                                </div>
                                <hr>
                                <#if car??>
                                    <#list car as cars>
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <p class="mb-0">${cars.model}</p>
                                            </div>
                                            <div class="col-sm-3">
                                                <p class="text-muted mb-0">${cars.number}</p>
                                            </div>
                                            <#if cars.active>
                                            <div class="col-sm-3">
                                                <p class="text-success mb-0">Подтвержден</p>
                                            </div>
                                                <#else>
                                                    <div class="col-sm-3">
                                                        <p class="text-danger mb-0">Проверка</p>
                                                    </div>
                                            </#if>
                                        </div>
                                        <hr>
                                    </#list>
                                </#if>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal" onclick="mask()">
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
                    <h5 class="modal-title" id="exampleModalLabel">Добавить новый автомобиль</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Пожалуйста введите модель автомобиля и его номер (После добавления необходимо дождаться подтверждения)
                    <form method="post" id="newCar">
                        <div class="form-group">
                            <label class="col-sm-2 col-form-label"> Модель: </label>
                            <div class="col-sm-6">
                                <input type="text" name="modelCar" class="form-control" placeholder="Модель автомобиля" required/>
                            </div>
                            <label class="col-sm-2 col-form-label"> Номер (Большими буквами): </label>
                            <div class="col-sm-6">
                                <input type="text" name="number" class="mask-car form-control text-uppercase" placeholder="A000AA"/>
                            </div>
                        </div>
                        <input type="hidden" name="_csrf" value="${_csrf.token}" />
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Отмена</button>
                            <button type="submit" class="btn btn-primary" name="delete">Добавить</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script>
        $.mask.definitions['h'] = '[А-Я]';
        $('.mask-car').mask('h999hh');
    </script>
    <script>
    function form_submit(){
        document.getElementById("newCar").submit(); }
    </script>
</@common.page>