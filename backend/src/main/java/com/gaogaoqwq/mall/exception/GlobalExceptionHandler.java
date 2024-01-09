package com.gaogaoqwq.mall.exception;

import com.gaogaoqwq.mall.response.R;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.resource.NoResourceFoundException;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(NoResourceFoundException.class)
    public ResponseEntity<R> handleNoResourceFoundException(NoResourceFoundException e) {
        log.info("Handled exception: {}", e.getClass().getName());
        return new ResponseEntity<>(R.failure(e.getMessage()), HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<R> handleException(Exception e) {
        log.warn("Unhandled exception response: {}", e.getClass().getName());
        return new ResponseEntity<>(R.failure(e.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
    }

}
