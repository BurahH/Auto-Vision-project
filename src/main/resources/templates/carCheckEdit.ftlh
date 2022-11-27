<#import "parts/common.ftlh" as common>

<@common.page>
    <h2>Верифицировать автомобиль</h2>

    <form action="/checklist/carlist" method="post">
        <div class="form-group">
            <label class="col-sm-3 col-form-label"> ФИО пользователя : </label>
            <div class="col-sm-6">
                <p class="text-muted mb-0">${car.user.name}</p>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 col-form-label"> Модель автомобиля : </label>
            <div class="col-sm-6">
                <p class="text-muted mb-0">${car.model}</p>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 col-form-label"> Номер автомобиля : </label>
            <div class="col-sm-6">
                <p class="text-muted mb-0">${car.number}</p>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 col-form-label"> VIN автомобиля : </label>
            <div class="col-sm-6">
                <p class="text-muted mb-0">${car.vin}</p>
            </div>
        </div>

        <div class="card mb-8 mb-lg-0">
            <div class="card-body p-0">
                <a class="btn btn-link btn-block text-left" data-toggle="collapse" href="#multiCollapseExample1" role="button" aria-expanded="false" aria-controls="multiCollapseExample1">Полис ОСАГО пользователя</a>
            </div>
        </div>
        <div class="collapse multi-collapse card mb-8 mb-lg-0" id="multiCollapseExample1">
            <div class="card-body p-0">
                <img src="/img/${car.user.photoOsago}" alt="osago" class="rounded mx-auto d-block" style="width: 600px;height: 600px;">
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

        <input type="hidden" value="${car.id}" name="carId">
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit" class="btn btn-primary mb-2">Данные верны</button>
    </form>
    <a class="btn btn-light" href="/checklist/carlist" role="button">Назад</a>

</@common.page>