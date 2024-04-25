package com.gaogaoqwq.mall.view;

import com.gaogaoqwq.mall.entity.GoodOrder;
import com.gaogaoqwq.mall.enums.OrderState;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor
public class GoodOrderInfoView {

    private String id;

    private String imgUrl;

    private OrderState state;

    public static GoodOrderInfoView fromGoodOrder(GoodOrder order) {
        return GoodOrderInfoView.builder()
                .id(order.getId())
                .imgUrl(order.getGood().getPreviewImgUrl())
                .state(order.getState())
                .build();
    }

}
