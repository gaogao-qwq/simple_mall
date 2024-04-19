package com.gaogaoqwq.mall.exception;

import org.springframework.http.HttpStatus;

import com.gaogaoqwq.mall.entity.User;

public class CartNotFoundException extends MallException {

    public CartNotFoundException(String cartId) {
        super(String.valueOf("Cart not found by given id: ")
                .concat(cartId).concat("."), HttpStatus.NOT_FOUND);
    }

    public CartNotFoundException(User user) {
        super(String.valueOf("Cart not found by given user: ")
                .concat(user.getUsername()).concat("."), HttpStatus.NOT_FOUND);
    }

}
