<#import "parts/commonNew.ftlh" as common>

<@common.page>
    <div class="row">
        <div class="col-lg-6">
            <div class="card mb-4">
                <div class="card-body">
                    <div class="title3">Заезды/выезды с паркинга</div>
                    <div class="row">
                        <div class="col-sm-61">
                            <p class="mb-0">Время</p>
                        </div>
                        <div class="col-sm-61">
                                <p class="mb-0">Автомобиль</p>
                        </div>
                    </div>
                    <hr>
                    <#if story??>
                        <#list story as st>
                            <div class="row">
                                <div class="col-sm-62">
                                    <p class="mb-0">${st.time}</p>
                                </div>
                                <div class="col-sm-62">
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
                    <div class="title3">Парковочные места</div>
                    <div class="row">
                        <div class="col-sm-61">
                            <p class="mb-0">Номер парковочного места</p>
                        </div>
                        <div class="col-sm-61">
                            <p class="mb-0">Дата окончания аренды</p>
                        </div>
                    </div>
                    <hr>
                    <#if parkingPlace??>
                        <#list parkingPlace as par>
                            <div class="row">
                                <div class="col-sm-62">
                                    <p class="mb-0">${par.number}</p>
                                </div>
                                <div class="col-sm-62">
                                    <#if par.status == "Куплен">
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