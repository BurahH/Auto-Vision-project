<#import "parts/commonNew.ftlh" as common>

<@common.page>
    <div class="title">ЖК LETI STUDIO</div>
    
    <div class="park">
        <div class="background">
            <div class="background1">
                <img src="static/plan.png" alt="">
            </div>
            <div class="background2">
                <img src="static/plan.png" alt="">
            </div>
            <div class="plug">
                <div class="plug1"></div>
                <div class="plug2"></div>
                <div class="plug3"></div>
                <div class="plug4"></div>
                <div class="plug5"></div>
                <div class="plug6"></div>
            </div>
        </div>
        <div class="wr">Въезд/выезд</div>
        <div class="plc">
            <#list parking as par>
                <a class="plc${par.number}<#if par.status = "Куплен">-2</#if><#if par.status = "Арендован">-3</#if>" href="/parking/${par.number}" data-bs-toggle="tooltip" data-html="true" title="Цена аренды: ${par.price}
Цена покупки: ${par.priceBuy}<#if par.status = "Арендован">
Дата окончания аренды: ${par.endTime}
</#if>">${par.number}</a>
            </#list>
        </div>
    </div>
    <div class="info">
        <div class="info_back"></div>
        <div class="brn"></div>
        <div class="info_card">
            <div class="floor">1 этаж</div>
            <div class="min_price">Минимальная стоимость: ${min}</div>
            <div class="type">Тип: наземный</div>
            <div class="free_plc">Количество свободных  мест: ${kolvo}</div>
        </div>
        <div class="des_card">
            <div class="des">Обозначения</div>
            <div class="free">Место свободно</div>
            <div class="sold">Место продано</div>
            <div class="reserved">Место арендовано</div>
            <div class="pts1">
                <img src="static/ec1.png" alt="">
            </div>    
            <div class="pts2">    
                <img src="static/ec2.png" alt="">
            </div>      
            <div class="pts3">
                <img src="static/ec3.png" alt="">
            </div> 
        </div>
    </div>
    </@common.page>