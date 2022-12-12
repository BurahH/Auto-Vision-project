<#import "parts/commonNew.ftlh" as common>

<@common.page>
    <div class="title2">Определение номера</div>
    <form method="post" enctype="multipart/form-data" action="/checkAuto">
        <div class="form-group">
            <div class="col-sm-21"> Фото автомобиля : </div>
            <div class="col-sm-6">
                <input type="file" name="photo" required>
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit" class="btn btnp">Отправить</button>
    </form>
    <div class="form-group">
        <label class="col-sm-21 col-form-label"> Определившийся номер : </label>
        <div class="col-sm-21">
            <p class="text-muted mb-0"><#if number??>${number}</#if></p>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-21 col-form-label"> Доступ на парковку : </label>
        <div class="col-sm-21">
            <p class="text-muted mb-0"><#if access??><#if access>Разрешен<#else>Запрещен</#if></#if></p>
        </div>
    </div>

</@common.page>