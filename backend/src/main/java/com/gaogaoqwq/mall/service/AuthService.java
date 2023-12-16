package com.gaogaoqwq.mall.service;

import com.gaogaoqwq.mall.response.R;

public interface AuthService {

    R login(String username, String password);

    R register(String username, String password);

    R refreshToken(String accessToken, String refreshToken);

}
