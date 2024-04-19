package com.gaogaoqwq.mall.exception;

import org.springframework.http.HttpStatus;

import lombok.Getter;

@Getter
public class MallException extends RuntimeException {

    private HttpStatus statusCode;

    public MallException() {
        super();
    }

    public MallException(String message) {
        super(message);
    }

    public MallException(String message, HttpStatus statusCode) {
        super(message);
        this.statusCode = statusCode;
    }

}
