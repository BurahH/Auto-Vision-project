<#import "parts/commonNew.ftlh" as common>
<#import "parts/login.ftlh" as login>

<@common.page>
    <script src="https://snipp.ru/cdn/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://snipp.ru/cdn/maskedinput/jquery.maskedinput.min.js"></script>
    <#if message??>
        <div class="alert alert-danger" role="alert">
            ${message}
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </#if>
    <div class="title2">Редактирование пользователя</div>
    <form method="post" enctype="multipart/form-data">
        <div class="form-group">
            <div class="col-sm-21"> ФИО : </div>
            <div class="col-sm-6">
                <input type="text" name="name" class="form-control2" value="<#if user.name??>${user.name}</#if>" placeholder="ФИО"/>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-21"> Номер телефона : </div>
            <div class="col-sm-6">
                <input type="text" name="number" class="mask-number form-control2" placeholder="8(900) 000-00-00" value="<#if user.number??>${user.number}</#if>"/>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-21"> Ваше фото : </div>
            <div class="col-sm-6">
                <input type="file" name="photo">
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-21"> Фото ОСАГО : </div>
            <div class="col-sm-6">
                <input type="file" name="osago">
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit" class="btn btnp">Сохранить</button>
        <a class="btn btn-outline-secondary btnl" href="/profile" role="button">Назад</a>
    </form>
    <script>
        $.mask.definitions['h'] = '[А-Я]';
        $('.mask-number').mask('8(999) 999-99-99');
    </script>
</@common.page>