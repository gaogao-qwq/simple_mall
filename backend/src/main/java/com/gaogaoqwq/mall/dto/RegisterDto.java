package com.gaogaoqwq.mall.dto;

import com.gaogaoqwq.mall.enums.Gender;
import lombok.Data;

@Data
public class RegisterDto {

    private String username;

    private String password;

    private Gender gender;

}
