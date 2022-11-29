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
<h2>Редактировать парковочное место</h2>

<form action="/parking" method="post" id="editUser">
    <div class="form-group">
        <label class="col-sm-3 col-form-label"> Номер места : </label>
        <div class="col-sm-6">
            <p class="text-muted mb-0">${parking.number}</p>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 col-form-label"> Цена за бронирование (1 месяц) : </label>
        <div class="col-sm-6">
            <input type="text" name="price" class="form-control" value="<#if parking.price??>#{parking.price}</#if>" placeholder="Цена" required onkeyup="this.value = this.value.replace(/[^\d]/g,'');"/>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 col-form-label"> Цена покупки места : </label>
        <div class="col-sm-6">
            <input type="text" name="priceBuy" class="form-control" value="<#if parking.priceBuy??>#{parking.priceBuy}</#if>" placeholder="Цена на покупку" required onkeyup="this.value = this.value.replace(/[^\d]/g,'');"/>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 col-form-label"> Текущий статус : </label>
        <div class="col-sm-6">
            <p class="text-muted mb-0">${parking.status}</p>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 col-form-label"> Дата окончания аренды: </label>
        <div class="col-sm-6">
            <p class="text-muted mb-0"><#if parking.endTime??>${parking.endTime}<#else>Место не арендовано</#if></p>
        </div>
    </div>

        <input type="hidden" value="${parking.id}" name="parkingId">
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit" class="btn btn-primary mb-2">Сохранить</button>
</form>
<a class="btn btn-light" href="/parking" role="button">Назад</a>
</@common.page>