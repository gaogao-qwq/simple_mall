package com.gaogaoqwq.mall.response;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gaogaoqwq.mall.enums.ErrorMessage;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.access.AccessDeniedHandler;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class R {

    private Boolean success;

    private Integer code;

    private String message;

    private Long timestamp;

    private Object data;

    public static RBuilder defaultBuilder() {
        return R.builder()
            .success(true)
            .code(HttpServletResponse.SC_OK)
            .message("调用成功")
            .timestamp(System.currentTimeMillis())
            .data(null);
    }

    public static AuthenticationEntryPoint authFailure() {
        return (HttpServletRequest request, HttpServletResponse response, AuthenticationException authException) -> {
            response.setContentType("application/json;charset=utf-8");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write(new ObjectMapper().writeValueAsString(
                R.builder()
                    .success(false)
                    .code(HttpServletResponse.SC_UNAUTHORIZED)
                    .message(ErrorMessage.AUTHENTICATION_FAILED)
                    .timestamp(System.currentTimeMillis())
                    .data(null)
                    .build()
            ));
        };
    }

    public static AccessDeniedHandler accessDenied() {
        return (HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException) -> {
            response.setContentType("application/json;charset=utf-8");
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            response.getWriter().write(new ObjectMapper().writeValueAsString(
                R.builder()
                    .success(false)
                    .code(HttpServletResponse.SC_FORBIDDEN)
                    .message(ErrorMessage.PERMISSION_DENIED)
                    .timestamp(System.currentTimeMillis())
                    .data(null)
                    .build()
            ));
        };
    }

}
