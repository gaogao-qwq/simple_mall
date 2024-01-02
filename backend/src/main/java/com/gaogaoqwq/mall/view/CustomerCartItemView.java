package com.gaogaoqwq.mall.view;

import com.gaogaoqwq.mall.entity.Good;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor
public class CustomerCartItemView {

    private Long goodId;

    private String previewImgUrl;

    private String goodName;

    private String goodDescription;

    private int stock;

    private String price;

    public static CustomerCartItemView fromGood(Good good) {
        return CustomerCartItemView.builder()
            .goodId(good.getId())
            .previewImgUrl(good.getPreviewImgUrl())
            .goodName(good.getName())
            .goodDescription(good.getDescription())
            .stock(good.getStock())
            .price(good.getPrice().toString()).build();
    }

}

