package com.gaogaoqwq.mall.response;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gaogaoqwq.mall.enums.ErrorMessage;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.Data;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.access.AccessDeniedHandler;

@Data
public class R {

    private Boolean success;

    private Integer code;

    private String message;

    private Long timestamp;

    private Object data;

    public static R success() {
        return new R(true);
    }

    public static R success(String msg) {
        return new R(true).setMessage(msg);
    }

    public static R success(Object obj) {
        return new R(true).setData(obj);
    }

    public static R failure() {
        return new R(false);
    }

    public static R failure(String msg) {
        return new R(false).setMessage(msg);
    }

    public static R failure(Object obj) {
        return new R(false).setData(obj);
    }

    public static AuthenticationEntryPoint authFailure() {
        return (HttpServletRequest request, HttpServletResponse response, AuthenticationException authException) -> {
            response.setContentType("application/json;charset=utf-8");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write(new ObjectMapper().writeValueAsString(
                    new R(false)
                            .setCode(HttpServletResponse.SC_UNAUTHORIZED)
                            .setMessage(ErrorMessage.AUTHENTICATION_FAILED)
            ));
        };
    }

    public static AccessDeniedHandler accessDenied() {
        return (HttpServletRequest request, HttpServletResponse response, org.springframework.security.access.AccessDeniedException accessDeniedException) -> {
            response.setContentType("application/json;charset=utf-8");
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            response.getWriter().write(new ObjectMapper().writeValueAsString(
                    new R(false)
                            .setCode(HttpServletResponse.SC_FORBIDDEN)
                            .setMessage(ErrorMessage.PERMISSION_DENIED)
            ));
        };
    }

    private R setSuccess(Boolean success) {
        this.success = success;
        return this;
    }

    private R setCode(Integer code) {
        this.code = code;
        return this;
    }

    private R setMessage(String message) {
        this.message = message;
        return this;
    }

    private R setTimestamp(Long timestamp) {
        this.timestamp = timestamp;
        return this;
    }

    private R setData(Object obj) {
        this.data = obj;
        return this;
    }

    private R(boolean ok) {
        this.success = ok;
        this.code = ok ? 200 : 500;
        this.message = ok ? "调用成功" : "调用失败";
        this.timestamp = System.currentTimeMillis();
        this.data = null;
    }

}
