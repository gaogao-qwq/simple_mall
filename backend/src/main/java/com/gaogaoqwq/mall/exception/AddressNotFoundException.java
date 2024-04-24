package com.gaogaoqwq.mall.exception;

import java.util.List;

import org.springframework.http.HttpStatus;

public class AddressNotFoundException extends MallException {

    public AddressNotFoundException(String id) {
        super(String.valueOf("Address not found by given id: ")
                .concat(id).concat("."), HttpStatus.NOT_FOUND);
    }

    public AddressNotFoundException(List<String> ids) {
        super(String.valueOf("Address not found by given ids: ")
                .concat(String.join(",", ids)), HttpStatus.NOT_FOUND);
    }

}
