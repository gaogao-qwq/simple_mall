package com.gaogaoqwq.mall.exception;

import com.gaogaoqwq.mall.response.R;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(Exception.class)
    public ResponseEntity<R> handleException(Exception e) {
        return new ResponseEntity<>(R.failure(e.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
    }

}
