package com.gaogaoqwq.mall.properties;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;

@Data
@ConfigurationProperties(prefix = "jwt.properties")
public class JwtProperties {

    private String secretKey;

    private Long accessTokenExpiration;

    private Long refreshTokenExpiration;

}

