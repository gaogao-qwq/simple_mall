package com.gaogaoqwq.mall.exception;

import lombok.Getter;

@Getter
public class ProvinceNotFoundException extends RuntimeException {

    private final Integer code;

    private final String message;

    public ProvinceNotFoundException(Integer code) {
        this.code = code;
        this.message = String.valueOf("Province not found by given code: ")
                .concat(String.valueOf(code).concat("."));
    }

}
