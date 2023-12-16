package com.gaogaoqwq.mall.filter;

import com.gaogaoqwq.mall.security.JwtProvider;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.io.IOException;
import java.util.Optional;

@Slf4j
@RequiredArgsConstructor
public class JwtFilter extends GenericFilter {

    private JwtProvider jwtProvider;

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        Optional<String> token = resolveToken((HttpServletRequest) request);
    }

    Optional<String> resolveToken(HttpServletRequest request) {
        String token = request.getHeader("Authorization");
        return Optional.empty();
    }
}
