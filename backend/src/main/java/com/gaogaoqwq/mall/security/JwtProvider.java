package com.gaogaoqwq.mall.security;

import com.gaogaoqwq.mall.properties.JwtProperties;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.io.ParserBuilder;
import io.jsonwebtoken.security.Keys;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@Component
@RequiredArgsConstructor
public class JwtProvider {

    private final JwtProperties jwtProperties;

    private SecretKey secretKey;

    @PostConstruct
    public void init() {
        String secret = Base64.getEncoder().encodeToString(this.jwtProperties.getSecretKey().getBytes());
        this.secretKey = Keys.hmacShaKeyFor(secret.getBytes());
    }

    public String generateAccessToken(Authentication authentication) {
        return createToken(authentication.getPrincipal().toString(), this.jwtProperties.getAccessTokenExpiration());
    }

    public String generateRefreshToken(Authentication authentication) {
        return createToken(authentication.getPrincipal().toString(), this.jwtProperties.getRefreshTokenExpiration());
    }

    private String createToken(String subject, Long expiration) {
        Date now = new Date();
        Date expirationDate = new Date(now.getTime() + expiration);
        return Jwts.builder()
                .subject(subject)
                .issuedAt(now)
                .expiration(expirationDate)
                .signWith(this.secretKey)
                .compact();
    }

}
