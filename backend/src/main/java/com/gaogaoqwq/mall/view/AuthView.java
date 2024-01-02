package com.gaogaoqwq.mall.view;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor
public class AuthView {

    private String username;

    private String accessToken;

    private String refreshToken;

}
