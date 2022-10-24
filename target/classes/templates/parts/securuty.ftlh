<#assign
    known = Session.SPRING_SECURITY_CONTEXT??
>

<#if known>
    <#assign
        user = Session.SPRING_SECURITY_CONTEXT.authentication.principal
        name = user.getUsername()
        isAdmin = user.isAdmin()
        isWatchman = user.isWatchman()
        isFullUser = user.isFullUser()
    >
<#else>
    <#assign
        name = "unknown"
        isAdmin = false
        isWatchman = false
        isFullUser = false
        >
</#if>