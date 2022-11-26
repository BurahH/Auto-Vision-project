<#import "parts/common.ftlh" as common>

<@common.page>
    <h2>Редактировать пользователя</h2>

    <form action="/checklist" method="post">
        <div class="form-group">
            <label class="col-sm-2 col-form-label"> Логин : </label>
            <div class="col-sm-6">
                <p class="text-muted mb-0">${user.username}</p>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 col-form-label"> ФИО : </label>
            <div class="col-sm-6">
                <p class="text-muted mb-0">${user.name}</p>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 col-form-label"> Номер телефона : </label>
            <div class="col-sm-6">
                <p class="text-muted mb-0">${user.number}</p>
            </div>
        </div>

        <div class="card mb-8 mb-lg-0">
            <div class="card-body p-0">
                <a class="btn btn-link btn-block text-left" data-toggle="collapse" href="#multiCollapseExample1" role="button" aria-expanded="false" aria-controls="multiCollapseExample1">Полис ОСАГО</a>
            </div>
        </div>
        <div class="collapse multi-collapse card mb-8 mb-lg-0" id="multiCollapseExample1">
            <div class="card-body p-0">
                <img src="/img/${user.photoOsago}" alt="osago" class="rounded mx-auto d-block" style="width: 600px;height: 600px;">
            </div>
        </div>

        <div class="card mb-8 mb-lg-0">
            <div class="card-body p-0">
                <a class="btn btn-link btn-block text-left" data-toggle="collapse" href="#multiCollapseExample2" role="button" aria-expanded="false" aria-controls="multiCollapseExample1">Фото пользователя</a>
            </div>
        </div>
        <div class="collapse multi-collapse card mb-8 mb-lg-0" id="multiCollapseExample2">
            <div class="card-body p-0">
                <img src="/img/${user.photo}" alt="osago" class="rounded mx-auto d-block" style="width: 600px;height: 600px;">
            </div>
        </div>

        <input type="hidden" value="${user.id}" name="userId">
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit" class="btn btn-primary mb-2">Данные верны</button>
    </form>
    <a class="btn btn-light" href="/user/list" role="button">Назад</a>

</@common.page>