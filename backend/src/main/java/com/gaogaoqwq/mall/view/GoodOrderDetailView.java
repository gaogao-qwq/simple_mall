package com.gaogaoqwq.mall.view;

import com.gaogaoqwq.mall.entity.GoodOrder;
import com.gaogaoqwq.mall.enums.OrderState;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor
public class GoodOrderDetailView {

    private String id;

    private Long goodId;

    private String imgUrl;

    private String recipient;

    private String phoneNumber;

    private String address;

    private OrderState state;

    public static GoodOrderDetailView fromGoodOrder(GoodOrder order) {
        return GoodOrderDetailView.builder()
                .id(order.getId())
                .goodId(order.getGood().getId())
                .imgUrl(order.getGood().getPreviewImgUrl())
                .recipient(order.getRecipient())
                .phoneNumber(order.getPhoneNumber())
                .address(order.getAddress())
                .state(order.getState())
                .build();
    }

}
