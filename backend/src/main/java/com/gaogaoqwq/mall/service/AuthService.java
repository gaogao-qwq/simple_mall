package com.gaogaoqwq.mall.service;

import com.gaogaoqwq.mall.dto.RegisterDto;
import com.gaogaoqwq.mall.response.R;

public interface AuthService {

    R login(String username, String password);

    R register(RegisterDto dto);

    R refreshToken(String accessToken, String refreshToken);

}
