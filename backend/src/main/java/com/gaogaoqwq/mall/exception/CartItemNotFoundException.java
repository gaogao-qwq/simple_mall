package com.gaogaoqwq.mall.exception;

import org.springframework.http.HttpStatus;

public class CartItemNotFoundException extends MallException {

    public CartItemNotFoundException(String id) {
        super(String.valueOf("Cart item not found by given id: ")
                .concat(String.valueOf(id)).concat("."), HttpStatus.NOT_FOUND);
    }

}
