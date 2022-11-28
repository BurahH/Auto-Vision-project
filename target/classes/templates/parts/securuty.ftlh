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
        isUser = user.isUser()
        isActive = user.isActive()
    >
<#else>
    <#assign
        name = "unknown"
        isAdmin = false
        isWatchman = false
        isFullUser = false
        isUser = false
        isActive = false
        >
</#if>