package com.gaogaoqwq.mall.config;

import com.gaogaoqwq.mall.enums.ErrorMessage;
import com.gaogaoqwq.mall.enums.RoleName;
import com.gaogaoqwq.mall.filter.JwtFilter;
import com.gaogaoqwq.mall.repository.UserRepository;
import com.gaogaoqwq.mall.response.R;
import com.gaogaoqwq.mall.service.UserService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
public class SecurityConfig {

    @Bean
    SecurityFilterChain webFilterChain(HttpSecurity http, JwtFilter jwtFilter) throws Exception {
        return http
                .httpBasic(AbstractHttpConfigurer::disable)
                .csrf(AbstractHttpConfigurer::disable)
                .sessionManagement(c -> c.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .exceptionHandling(c -> c.authenticationEntryPoint(R.authFailure()))
                .exceptionHandling(c -> c.accessDeniedHandler(R.accessDenied()))
                .addFilterAfter(jwtFilter, UsernamePasswordAuthenticationFilter.class)
                .authorizeHttpRequests(authorize -> authorize
                        .requestMatchers("/swagger-ui.html").permitAll()
                        .requestMatchers("/swagger-ui/**").permitAll()
                        .requestMatchers("/v1/api-docs/**").permitAll()
                        .requestMatchers("/v1/auth/**").permitAll()
                        .requestMatchers("/v1/good/**").permitAll()
                        .requestMatchers("/v1/customer/**").hasRole(RoleName.CUSTOMER)
                        .requestMatchers("/v1/good-management/**").hasRole(RoleName.ADMIN)
                )
                .build();
    }

    @Bean
    UserDetailsService customUserDetailsService(UserRepository userRepository)
            throws UsernameNotFoundException {
        return (username) -> userRepository.findUserByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException(ErrorMessage.USERNAME_NOT_EXIST));
    }

    @Bean
    AuthenticationManager customAuthenticationManager(
            UserService userService,
            PasswordEncoder passwordEncoder
    ) throws AuthenticationException {
        return authentication -> {
            String username = String.valueOf(authentication.getPrincipal());
            String password = String.valueOf(authentication.getCredentials());

            UserDetails userDetails = userService.loadUserByUsername(username);

            if (!passwordEncoder.matches(password, userDetails.getPassword())) {
                throw new BadCredentialsException(ErrorMessage.PASSWORD_ERROR);
            }

            if (!userDetails.isEnabled()) {
                throw new DisabledException(ErrorMessage.USER_DISABLE);
            }

            return new UsernamePasswordAuthenticationToken(username, password, userDetails.getAuthorities());
        };
    }

    @Bean
    PasswordEncoder customPasswordEncoder() {
        return PasswordEncoderFactories.createDelegatingPasswordEncoder();
    }

}
