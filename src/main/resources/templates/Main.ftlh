<#import "parts/common.ftlh" as common>

<@common.page>
    <div>
        <form method="post" enctype="multipart/form-data">
            <input type="text" name="text" placeholder="Введите сообщение" />
            <input type="text" name="tag" placeholder="Тэг">
            <input type="file" name="file">
            <input type="hidden" name="_csrf" value="${_csrf.token}" />
            <button type="submit">Добавить</button>
        </form>
    </div>
    <div>Список сообщений</div>
    <form method="get" action="/main">
        <input type="text" name="filter" value="${filter!""}" />
        <button type="submit">Найти</button>
    </form>
    <#list messages as message>
        <div>
            <b>${message.id!" "}</b>
            <span>${message.text}</span>
            <i>${message.tag}</i>
            <div>
                <#if message.filename??>
                    <img src="/img/${message.filename}">
                </#if>
            </div>
        </div>
    <#else>
        No message
    </#list>
</@common.page>