package com.AutoVision.servingwebcontent.domain;

import org.springframework.security.core.GrantedAuthority;

public enum Role  implements GrantedAuthority {
    USER, ADMIN, FULL_USER, WATCHMAN;

    @Override
    public String getAuthority() {
        return name();
    }
}
