package com.gaogaoqwq.mall.controller.v1;

import com.gaogaoqwq.mall.dto.LoginDto;
import com.gaogaoqwq.mall.dto.RefreshDto;
import com.gaogaoqwq.mall.dto.RegisterDto;
import com.gaogaoqwq.mall.response.R;
import com.gaogaoqwq.mall.service.AuthService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/v1/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;

    @PostMapping("/login")
    public R login(@RequestBody LoginDto dto) {
        return authService.login(dto.getUsername(), dto.getPassword());
    }

    @PostMapping("/register")
    public R register(@RequestBody RegisterDto dto) {
        return authService.register(dto.getUsername(), dto.getPassword());
    }

    @PostMapping("/refresh")
    public R refresh(@RequestBody RefreshDto dto) {
        return authService.refreshToken(dto.getAccessToken(), dto.getRefreshToken());
    }

}
