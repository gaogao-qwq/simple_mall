package com.gaogaoqwq.mall.dto;

import lombok.Data;

@Data
public class AddressDto {

    private Long userId;

    private String recipient;

    private String phoneNumber;

    private String province;

    private String detail;

}
