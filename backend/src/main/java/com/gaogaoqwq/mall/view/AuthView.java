package com.gaogaoqwq.mall.view;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor
public class AuthView {

    public String username;

    public String accessToken;

    public String refreshToken;

}
