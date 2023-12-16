package com.gaogaoqwq.mall.util;

import lombok.extern.slf4j.Slf4j;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Optional;

@Slf4j
public class Encryption {

    public static Optional<String> SHA256Encrypt(String password) {
        byte[] hash;
        try {
            hash = MessageDigest.getInstance("SHA-256").digest(password.getBytes());
        } catch (NoSuchAlgorithmException e) {
            log.error("SHA-256 encryption failed: {}", e.getMessage());
            return Optional.empty();
        }
        return Optional.of(Base64.getEncoder().encodeToString(hash));
    }

}
