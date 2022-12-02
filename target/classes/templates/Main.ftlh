<#import "parts/commonNew.ftlh" as common>

<@common.page>
    <div class="row">
        <div class="col-lg-6">
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="my-3">Заезды/выезды с паркинга</h5>
                    <div class="row">
                        <div class="col-sm-6">
                            <p class="mb-0">Время</p>
                        </div>
                        <div class="col-sm-6">
                                <p class="mb-0">Автомобиль</p>
                        </div>
                    </div>
                    <hr>
                    <#if story??>
                        <#list story as st>
                            <div class="row">
                                <div class="col-sm-6">
                                    <p class="mb-0">${st.time}</p>
                                </div>
                                <div class="col-sm-6">
                                    <p class="mb-0">${st.car.model}</p>
                                </div>
                            </div>
                            <hr>
                        </#list>
                        <#else>
                            <div class="row">
                            <div class="col-sm-12">
                                <p class="mb-0">Нет заездов на парковку</p>
                            </div>
                            </div>
                    </#if>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="my-3">Парковочные места</h5>
                    <div class="row">
                        <div class="col-sm-6">
                            <p class="mb-0">Номер парковочного места</p>
                        </div>
                        <div class="col-sm-6">
                            <p class="mb-0">Дата окончания аренды</p>
                        </div>
                    </div>
                    <hr>
                    <#if parkingPlace??>
                        <#list parkingPlace as par>
                            <div class="row">
                                <div class="col-sm-6">
                                    <p class="mb-0">${par.number}</p>
                                </div>
                                <div class="col-sm-6">
                                    <#if par.status??>
                                        <p class="mb-0">Куплено</p>
                                    <#else>
                                        <p class="mb-0">${par.endTime}</p>
                                    </#if>
                                </div>
                            </div>
                            <hr>
                        </#list>
                    <#else>
                        <div class="row">
                            <div class="col-sm-12">
                                <p class="mb-0">Не зарегистрировано въездов или выездов</p>
                            </div>
                        </div>
                    </#if>
                </div>
            </div>
        </div>
    </div>
</@common.page>