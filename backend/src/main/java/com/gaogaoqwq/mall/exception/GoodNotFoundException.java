package com.gaogaoqwq.mall.exception;

import org.springframework.http.HttpStatus;

public class GoodNotFoundException extends MallException {

    public GoodNotFoundException(Long id) {
        super(String.valueOf("Good not found by given id: ")
                .concat(String.valueOf(id)).concat("."), HttpStatus.NOT_FOUND);
    }

}
