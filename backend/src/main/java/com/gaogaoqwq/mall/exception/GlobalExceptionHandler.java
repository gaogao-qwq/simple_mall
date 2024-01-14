package com.gaogaoqwq.mall.exception;

import com.gaogaoqwq.mall.enums.ErrorMessage;
import com.gaogaoqwq.mall.response.R;

import jakarta.servlet.http.HttpServletResponse;

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
        return new ResponseEntity<>(R.successBuilder()
                .success(false)
                .message(ErrorMessage.API_NOT_FOUND)
                .code(HttpServletResponse.SC_NOT_FOUND)
                .build(),
            HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<R> handleException(Exception e) {
        log.warn("Unhandled exception response: {}", e.getClass().getName());
        return new ResponseEntity<>(R.successBuilder()
                .success(false)
                .code(HttpServletResponse.SC_INTERNAL_SERVER_ERROR)
                .message(ErrorMessage.INTERNAL_SERVER_ERROR)
                .build(),
            HttpStatus.INTERNAL_SERVER_ERROR);
    }

}
