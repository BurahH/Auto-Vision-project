<#import "parts/commonNew.ftlh" as common>

<@common.page>
    <script src="https://snipp.ru/cdn/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://snipp.ru/cdn/maskedinput/jquery.maskedinput.min.js"></script>
    <h2>Новая карта</h2>
    <form action="/card" method="post">
<div class="form-group">
    <label class="col-sm-2 col-form-label"> Номер карты: </label>
    <div class="col-sm-6">
        <input type="text" name="number" class="mask-number form-control" placeholder="____-____-____-____" required/>
    </div>
</div>
<div class="form-group">
    <label class="col-sm-2 col-form-label"> Срок действия: </label>
    <div class="col-sm-6">
        <input type="text" name="date" class="mask-srok form-control" placeholder="00/00" required/>
    </div>
</div>
<div class="form-group">
    <label class="col-sm-2 col-form-label"> Владелец карты: </label>
    <div class="col-sm-6">
        <input type="text" name="name" class="form-control" placeholder="Ivan Ivanov" required/>
    </div>
</div>
<div class="form-group">
    <label class="col-sm-2 col-form-label"> CVC код: </label>
    <div class="col-sm-6">
        <input type="password" name="cvc" class="mask-cvc form-control" placeholder="***" required/>
    </div>
</div>
        <div class="form-group">
            <label class="col-sm-2 col-form-label"> Деньги на карте: </label>
            <div class="col-sm-6">
                <input type="number" name="moneyCard" class="form-control" placeholder="money"required/>
            </div>
        </div>
</div>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit" class="btn">Сохранить</button>
    </form>
    <script>
        $('.mask-number').mask('9999-9999-9999-9999');
        $('.mask-srok').mask('99/99');
        $('.mask-cvc').mask('999');
    </script>

</@common.page>