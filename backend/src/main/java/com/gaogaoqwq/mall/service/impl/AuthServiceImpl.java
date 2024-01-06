package com.gaogaoqwq.mall.service.impl;

import com.gaogaoqwq.mall.dto.RegisterDto;
import com.gaogaoqwq.mall.entity.User;
import com.gaogaoqwq.mall.enums.ErrorMessage;
import com.gaogaoqwq.mall.enums.RoleName;
import com.gaogaoqwq.mall.repository.RoleRepository;
import com.gaogaoqwq.mall.repository.UserRepository;
import com.gaogaoqwq.mall.response.R;
import com.gaogaoqwq.mall.security.JwtProvider;
import com.gaogaoqwq.mall.service.AuthService;
import com.gaogaoqwq.mall.view.AuthView;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class AuthServiceImpl implements AuthService {

    private final AuthenticationManager authenticationManager;
    private final PasswordEncoder passwordEncoder;
    private final JwtProvider jwtProvider;
    private final UserRepository userRepo;
    private final RoleRepository roleRepo;

    @Override
    public R login(String username, String password) {
        // 用户信息校验
        Authentication authentication = new UsernamePasswordAuthenticationToken(username, password);
        try {
            authentication = authenticationManager.authenticate(authentication);
        } catch (UsernameNotFoundException e) {
            return R.failure(ErrorMessage.USERNAME_NOT_EXIST);
        } catch (DisabledException e) {
            return R.failure(ErrorMessage.USER_DISABLE);
        } catch (BadCredentialsException e) {
            return R.failure(ErrorMessage.PASSWORD_ERROR);
        } catch (Exception e) {
            return R.failure(ErrorMessage.UNKNOWN_ERROR);
        }

        // 生成 JWT
        final String accessToken = jwtProvider.generateAccessToken(authentication.getPrincipal().toString());
        final String refreshToken = jwtProvider.generateRefreshToken(authentication.getPrincipal().toString());
        AuthView view = new AuthView(username, accessToken, refreshToken);

        return R.success(view);
    }

    @Override
    @Transactional
    public R register(RegisterDto dto) {
        if (userRepo.existsByUsername(dto.getUsername())) {
            return R.failure(ErrorMessage.USER_EXIST);
        }

        var role = roleRepo.findByName("ROLE_" + RoleName.CUSTOMER);
        if (role.isEmpty()) {
            return R.failure(ErrorMessage.INTERNAL_SERVER_ERROR);
        }

        User user = User.builder()
                .username(dto.getUsername())
                .password(passwordEncoder.encode(dto.getPassword()))
                .gender(dto.getGender())
                .role(role.get())
                .enable(true).build();
        userRepo.save(user);

        // 生成 JWT
        String accessToken = jwtProvider.generateAccessToken(dto.getUsername());
        String refreshToken = jwtProvider.generateRefreshToken(dto.getUsername());
        AuthView view = new AuthView(dto.getUsername(), accessToken, refreshToken);

        return R.success(view);
    }

    @Override
    public R refreshToken(String refreshToken) {
        if (!jwtProvider.validateToken(refreshToken)) {
            return R.failure(ErrorMessage.TOKEN_EXPIRED);
        }

        var userOpt = jwtProvider.authenticateToken(refreshToken);
        if (userOpt.isEmpty()) return R.failure(ErrorMessage.USERNAME_NOT_EXIST);
        var user = userOpt.get();
        if (!user.isEnabled()) return R.failure(ErrorMessage.USER_DISABLE);

        final String accessToken = jwtProvider.generateAccessToken(userOpt.get().getUsername());
        refreshToken = jwtProvider.generateRefreshToken(userOpt.get().getUsername());
        AuthView view = new AuthView(userOpt.get().getUsername(), accessToken, refreshToken);
        return R.success(view);
    }

}
