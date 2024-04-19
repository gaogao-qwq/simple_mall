package com.gaogaoqwq.mall.exception;

import org.springframework.http.HttpStatus;

public class AddressNotFoundException extends MallException {

    public AddressNotFoundException(String id) {
        super(String.valueOf("Address not found by given code: ")
                .concat(id).concat("."), HttpStatus.NOT_FOUND);
    }

}
