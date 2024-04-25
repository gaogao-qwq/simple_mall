package com.gaogaoqwq.mall.exception;

import org.springframework.http.HttpStatus;

import com.gaogaoqwq.mall.entity.User;

public class OrderNotFoundException extends MallException {

    public OrderNotFoundException(String id) {
        super(String.valueOf("Order not found by given id: ")
                .concat(id).concat("."), HttpStatus.NOT_FOUND);
    }

    public OrderNotFoundException(User user, String id) {
        super(String.valueOf("Order with id: ")
                .concat(id).concat(" not found by user: ")
                .concat(user.getUsername()).concat("."),
                HttpStatus.NOT_FOUND);
    }

}
