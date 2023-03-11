<#import "parts/commonNew.ftlh" as common>

<@common.page>
    <div class="title2">Верифицировать автомобиль</div>

    <form action="/checklist/carlist" method="post">
        <div class="form-group">
            <label class="col-sm-31 col-form-label"> ФИО пользователя : </label>
            <div class="col-sm-62">
                <p class="text-muted mb-0"><#if car.user.name??>${car.user.name}</#if></p>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-31 col-form-label"> Модель автомобиля : </label>
            <div class="col-sm-62">
                <p class="text-muted mb-0">${car.model}</p>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-31 col-form-label"> Номер автомобиля : </label>
            <div class="col-sm-62">
                <p class="text-muted mb-0">${car.number}</p>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-31 col-form-label"> VIN автомобиля : </label>
            <div class="col-sm-62">
                <p class="text-muted mb-0">${car.vin}</p>
            </div>
        </div>

        <div>
            <div class="card-body p-0">
                <a class="btn btns" data-toggle="collapse" href="#multiCollapseExample1" role="button" aria-expanded="false" aria-controls="multiCollapseExample1">Полис ОСАГО пользователя</a>
            </div>
        </div>
        
        <div class="collapse" id="multiCollapseExample1">
            <div class="card card-body">
                <img src="/img/<#if car.user.photoOsago??>${car.user.photoOsago}<#else>documentstandart.png</#if>" alt="osago" class="rounded mx-auto d-block" style="width: 600px;height: 600px;">
            </div>
        </div>

        <div>
            <div class="card-body p-0">
                <a class="btn btns" data-toggle="collapse" href="#multiCollapseExample2" role="button" aria-expanded="false" aria-controls="multiCollapseExample1">СТС автомобиля</a>
            </div>
        </div>
        <div class="collapse" id="multiCollapseExample2">
            <div class="card card-body">
                <img src="/img/${car.sts}" alt="osago" class="rounded mx-auto d-block" style="width: 600px;height: 600px;">
            </div>
        </div>

        <input type="hidden" value="${car.id}" name="carId">
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit" class="btn btnp3">Данные верны</button>
    </form>
    <form action="/checklist/carlist/${car.id}" method="get">
        <input type="hidden" value="${car.id}" name="carid">
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit" class="btn btnp3">Отказ в верификации</button>
        <a class="btn btn-outline-secondary btnl" href="/checklist/carlist" role="button">Назад</a>
    </form>

</@common.page>