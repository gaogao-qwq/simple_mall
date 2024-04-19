package com.gaogaoqwq.mall.exception;

import org.springframework.http.HttpStatus;

public class ProvinceNotFoundException extends MallException {

    public ProvinceNotFoundException(Integer code) {
        super(String.valueOf("Province not found by given code: ")
                .concat(String.valueOf(code)).concat("."), HttpStatus.NOT_FOUND);
    }

}
