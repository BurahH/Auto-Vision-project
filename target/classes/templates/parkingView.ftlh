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
    <script src="https://snipp.ru/cdn/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://snipp.ru/cdn/maskedinput/jquery.maskedinput.min.js"></script>
<h2>Купить парковочное место</h2>

    <div class="form-group">
        <label class="col-sm-3 col-form-label"> Номер места : </label>
        <div class="col-sm-6">
            <p class="text-muted mb-0">${parking.number}</p>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 col-form-label"> Номер места : </label>
        <div class="col-sm-6">
            <p class="text-muted mb-0">${parking.price}</p>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 col-form-label"> Номер места : </label>
        <div class="col-sm-6">
            <p class="text-muted mb-0">${parking.priceBuy}</p>
        </div>
    </div>
    <div>
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal">
           Купить место
        </button>
    </div>

    <div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Купить парковочное место</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="resetLogin()">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form method="post" action="/parking/view">
                <div class="modal-body">
                    Пожалуйста заполните реквизиты карты для покупки
                    <div class="form-group">
                        <label class="col-sm-2 col-form-label"> Номер карты: </label>
                        <div class="col-sm-6">
                            <input type="text" name="number" class="mask-number form-control" placeholder="____-____-____-____" id="Login" required/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 col-form-label"> Срок действия: </label>
                        <div class="col-sm-6">
                            <input type="text" name="srok" class="mask-srok form-control" placeholder="00/00" id="Login" required/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 col-form-label"> Владелец карты: </label>
                        <div class="col-sm-6">
                            <input type="text" name="name" class="form-control" placeholder="Ivan Ivanov" id="Login" required/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 col-form-label"> CVC код: </label>
                        <div class="col-sm-6">
                            <input type="password" name="cvc" class="mask-cvc form-control" placeholder="***" id="Login" required/>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="resetLogin()">Отмена</button>
                    <button type="submit" class="btn btn-primary" name="delete">Купить</button>
                </div>
                </form>
            </div>
        </div>
    </div>

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
<a class="btn btn-light" href="/parking" role="button">Назад</a>
</@common.page>