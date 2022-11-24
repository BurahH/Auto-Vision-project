<#import "parts/common.ftlh" as common>
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
    <h2>Редактированеи пользователя</h2>
    <form method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label class="col-sm-2 col-form-label"> ФИО : </label>
            <div class="col-sm-6">
                <input type="text" name="name" class="form-control" value="<#if user.name??>${user.name}</#if>" placeholder="ФИО"/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 col-form-label"> Номер телефона : </label>
            <div class="col-sm-6">
                <input type="text" name="number" class="mask-number form-control" placeholder="8(900) 000-00-00" value="<#if user.number??>${user.number}</#if>"/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 col-form-label"> Ваше фото : </label>
            <div class="col-sm-6">
                <input type="file" name="photo">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 col-form-label"> Фото ОСАГО : </label>
            <div class="col-sm-6">
                <input type="file" name="osago">
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit" class="btn btn-primary mb-2" >Сохранить</button>
        <a class="btn btn-light" href="/profile" role="button">Назад</a>
    </form>
    <script>
        $.mask.definitions['h'] = '[А-Я]';
        $('.mask-number').mask('8(999) 999-99-99');
    </script>
</@common.page>