<#import "parts/commonNew.ftlh" as common>

<@common.page>
<#if message??>
<div class="${classInscription}" role="alert">
    ${message}
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
</#if>
<div class="title2">Редактировать парковочное место</div>

<form action="/parking" method="post" id="editUser">
    <div class="form-group">
        <label class="col-sm-21 col-form-label"> Номер места : </label>
        <div class="col-sm-21">
            <p class="text-muted mb-0">${parking.number}</p>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-21 col-form-label"> Цена за бронирование (1 месяц) : </label>
        <div class="col-sm-6">
            <input type="text" name="price" class="form-control2" value="<#if parking.price??>#{parking.price}</#if>" placeholder="Цена" required onkeyup="this.value = this.value.replace(/[^\d]/g,'');"/>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-21 col-form-label"> Цена покупки места : </label>
        <div class="col-sm-6">
            <input type="text" name="priceBuy" class="form-control2" value="<#if parking.priceBuy??>#{parking.priceBuy}</#if>" placeholder="Цена на покупку" required onkeyup="this.value = this.value.replace(/[^\d]/g,'');"/>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-21 col-form-label"> Текущий статус : </label>
        <div class="col-sm-21">
            <p class="text-muted mb-0">${parking.status}</p>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-21 col-form-label"> Дата окончания аренды: </label>
        <div class="col-sm-21">
            <p class="text-muted mb-0"><#if parking.endTime??>${parking.endTime}<#else>Место не арендовано</#if></p>
        </div>
    </div>

        <input type="hidden" value="${parking.id}" name="parkingId">
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit" class="btn btnp">Сохранить</button>
    <a class="btn btn-outline-secondary btnl" href="/parking" role="button">Назад</a>
</form>
</@common.page>