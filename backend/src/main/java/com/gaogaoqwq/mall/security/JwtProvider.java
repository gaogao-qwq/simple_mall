package com.gaogaoqwq.mall.security;

import com.gaogaoqwq.mall.properties.JwtProperties;
import com.gaogaoqwq.mall.service.UserService;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.util.Base64;
import java.util.Date;
import java.util.Optional;

@Slf4j
@Component
@RequiredArgsConstructor
public class JwtProvider {

    private final JwtProperties jwtProperties;
    private final UserService userService;

    private SecretKey secretKey;

    @PostConstruct
    public void init() {
        String secret = Base64.getEncoder().encodeToString(this.jwtProperties.getSecretKey().getBytes());
        this.secretKey = Keys.hmacShaKeyFor(secret.getBytes());
    }

    public String generateAccessToken(String username) {
        return createToken(username, this.jwtProperties.getAccessTokenExpiration());
    }

    public String generateRefreshToken(String username) {
        return createToken(username, this.jwtProperties.getRefreshTokenExpiration());
    }

    private String createToken(String subject, Long expiration) {
        Date now = new Date();
        Date expirationDate = new Date(now.getTime() + expiration);
        return Jwts.builder()
                .subject(subject)
                .issuedAt(now)
                .expiration(expirationDate)
                .signWith(this.secretKey, Jwts.SIG.HS256)
                .compact();
    }

    public boolean validateToken(String token) {
        try {
            Jwts.parser().verifyWith(this.secretKey).build().parseSignedClaims(token);
        } catch (Exception e) {
            return false;
        }
        return true;
    }

    public Optional<UserDetails> authenticateToken(String token) {
        String username = extractUsername(token);
        UserDetails userDetails;
        try {
            userDetails = userService.loadUserByUsername(username);
        } catch (Exception e) {
            return Optional.empty();
        }
        if (!userDetails.isEnabled()) return Optional.empty();
        if (!username.equals(userDetails.getUsername())) return Optional.empty();
        return Optional.of(userDetails);
    }

    private String extractUsername(String token) {
        return Jwts.parser()
                .verifyWith(this.secretKey)
                .build()
                .parseSignedClaims(token)
                .getPayload()
                .getSubject();
    }

}
