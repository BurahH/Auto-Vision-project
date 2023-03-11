<#import "parts/commonNew.ftlh" as common>

<@common.page>
    <div class="title2">Верифицировать пользователя</div>

    <form action="/checklist" method="post">
        <div class="form-group">
            <label class="col-sm-21 col-form-label"> Логин : </label>
            <div class="col-sm-62">
                <p class="text-muted mb-0">${user.username}</p>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-21 col-form-label"> ФИО : </label>
            <div class="col-sm-62">
                <p class="text-muted mb-0">${user.name}</p>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-21 col-form-label"> Номер телефона : </label>
            <div class="col-sm-62">
                <p class="text-muted mb-0">${user.number}</p>
            </div>
        </div>

        <div>
            <div class="card-body p-0">
                <a class="btn btns" data-toggle="collapse" href="#multiCollapseExample1" role="button" aria-expanded="false" aria-controls="multiCollapseExample1">Полис ОСАГО</a>
            </div>
        </div>
        <div class="collapse" id="multiCollapseExample1">
            <div class="card card-body">
                <img src="/img/${user.photoOsago}" alt="osago" class="rounded mx-auto d-block" style="width: 600px;height: 600px;">
            </div>
        </div>

        <div>
            <div class="card-body p-0">
                <a class="btn btns" data-toggle="collapse" href="#multiCollapseExample2" role="button" aria-expanded="false" aria-controls="multiCollapseExample1">Фото пользователя</a>
            </div>
        </div>
        <div class="collapse" id="multiCollapseExample2">
            <div class="card card-body">
                <img src="/img/${user.photo}" alt="osago" class="rounded mx-auto d-block" style="width: 600px;height: 600px;">
            </div>
        </div>

        <input type="hidden" value="${user.id}" name="userId">
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit" class="btn btnp3">Данные верны</button>
    </form>
    <form action="/checklist/${user.id}" method="get">
        <input type="hidden" value="${user.id}" name="id">
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit" class="btn btnp3">Отказ в верификации</button>
        <a class="btn btn-outline-secondary btnl" href="/checklist" role="button">Назад</a>
    </form>

</@common.page>