package com.gaogaoqwq.mall.filter;

import com.gaogaoqwq.mall.security.JwtProvider;
import com.gaogaoqwq.mall.service.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Optional;

@Slf4j
@RequiredArgsConstructor
@Component
public class JwtFilter extends GenericFilter {

    private final JwtProvider jwtProvider;
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        // 提取 token
        Optional<String> tokenOpt = resolveToken((HttpServletRequest) request);
        if (tokenOpt.isEmpty()) {
            SecurityContextHolder.setContext(SecurityContextHolder.createEmptyContext());
            chain.doFilter(request, response);
            return;
        }

        String token = tokenOpt.get();
        // 校验 token
        if (!jwtProvider.validateToken(token)) {
            SecurityContextHolder.setContext(SecurityContextHolder.createEmptyContext());
            chain.doFilter(request, response);
            return;
        }
        // 验证 token
        Optional<UserDetails> userDetailsOpt = jwtProvider.authenticateToken(token);
        if (userDetailsOpt.isEmpty()) {
            SecurityContextHolder.setContext(SecurityContextHolder.createEmptyContext());
            chain.doFilter(request, response);
            return;
        }
        UserDetails userDetails = userDetailsOpt.get();

        // 授权
        Authentication authentication = new UsernamePasswordAuthenticationToken(
                userDetails.getUsername(),
                userDetails.getPassword(),
                userDetails.getAuthorities()
        );
        SecurityContextHolder.getContext().setAuthentication(authentication);
        chain.doFilter(request, response);
    }

    public Optional<String> resolveToken(HttpServletRequest request) {
        String token = request.getHeader("Authorization");
        if (token != null && token.startsWith("Bearer ")) {
            return Optional.of(token.substring(7));
        }
        return Optional.empty();
    }
}
