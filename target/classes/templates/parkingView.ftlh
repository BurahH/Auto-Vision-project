<#import "parts/commonNew.ftlh" as common>

<@common.page>
<#if message??>
<div class="alert alert-danger" role="alert">
    ${message}
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
</#if>
    <script src="https://snipp.ru/cdn/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://snipp.ru/cdn/maskedinput/jquery.maskedinput.min.js"></script>
    <script>
        function buy() {
            const dateBuy = document.getElementById('dateBuy').value;
            if (dateBuy == 0) {
                document.getElementById('priceBuy').innerHTML = Number(#{parking.priceBuy});
            } else {
                document.getElementById('priceBuy').innerHTML = Number(dateBuy) * Number(#{parking.price});
            }
        }
    </script>
<div class="title2">Купить парковочное место</div>
    <form method="post" action="/view">
    <div class="form-group">
        <label class="col-sm-21 col-form-label"> Номер места : </label>
        <div class="col-sm-21">
            <p class="text-muted mb-0">${parking.number}</p>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-21 col-form-label"> Цена аренды за 1 месяц : </label>
        <div class="col-sm-21">
            <p class="text-muted mb-0" id="priceOne">${parking.price}</p>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-21 col-form-label"> Цена за покупку места : </label>
        <div class="col-sm-21">
            <p class="text-muted mb-0" id="priceBuyFull">${parking.priceBuy}</p>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-21 col-form-label"> Срок аренды в месяцах (Для покупки укажите 0): </label>
        <div class="col-sm-6">
            <input type="number" name="priceBuy" class="form-control2" value="0" placeholder="Срок" id="dateBuy" required/>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-21 col-form-label"> Цена покупки : </label>
        <div class="col-sm-21">
            <p class="text-muted mb-0" id="priceBuy"> </p>
        </div>
    </div>
        <div>
        <button type="button" class="btn btnp3" onclick="buy()">
            Расчитать цену
        </button>
        </div>
        <button type="button" class="btn btnp3" data-toggle="modal" data-target="#modal">
           Купить место
        </button>

    <div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Купить парковочное место</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="resetLogin()">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="col-sm-31">
                    Пожалуйста заполните реквизиты карты для покупки
                    (Перед покупкой пожалуйста активируйте почту, укажите личные данные и дождитесь их подтверждения)
                    <div class="form-group">
                        <label class="col-sm-21 col-form-label"> Номер карты: </label>
                        <div class="col-sm-6">
                            <input type="text" name="number" class="mask-number form-control2" placeholder="____-____-____-____" id="Login" required/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-21 col-form-label"> Срок действия: </label>
                        <div class="col-sm-6">
                            <input type="text" name="srok" class="mask-srok form-control2" placeholder="00/00" id="Login" required/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-21 col-form-label"> Владелец карты: </label>
                        <div class="col-sm-6">
                            <input type="text" name="name" class="form-control2" placeholder="Ivan Ivanov" id="Login" required/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-21 col-form-label"> CVC код: </label>
                        <div class="col-sm-6">
                            <input type="password" name="cvc" class="mask-cvc form-control2" placeholder="***" id="Login" required/>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="hidden" name="parkingPlaceId" value="${parking.id}" />
                    <input type="hidden" name="_csrf" value="${_csrf.token}" />
                    <button type="button" class="btn btn-outline-secondary btnl" data-dismiss="modal" onclick="resetLogin()">Отмена</button>
                    <button type="submit" class="btn btnp" name="delete">Купить</button>
                </div>
            </div>
        </div>
    </div>
        <a class="btn btn-outline-secondary btnl" href="/view" role="button">Назад</a>
    </form>

    <script>
        $('.mask-number').mask('9999-9999-9999-9999');
        $('.mask-srok').mask('99/99');
        $('.mask-cvc').mask('999');
    </script>
    <script>
        function resetLogin(){
            document.getElementById("Login").value = "";
        }
        function form_submit() {
            document.getElementById("editUser").submit();
        }
    </script>
</@common.page>