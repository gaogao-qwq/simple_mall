package com.gaogaoqwq.mall.view;

import com.gaogaoqwq.mall.entity.Address;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor
public class AddressView {

    private String id;

    private String recipient;

    private String phoneNumber;

    private Integer province;

    private String detail;

    private Boolean isDefault;

    public static AddressView fromAddress(Address address) {
        return AddressView.builder()
                .id(address.getId())
                .recipient(address.getRecipient())
                .phoneNumber(address.getPhoneNumber())
                .province(address.getProvince().getCode())
                .detail(address.getDetail())
                .isDefault(address.getDefaultUser() != null)
                .build();
    }

}
