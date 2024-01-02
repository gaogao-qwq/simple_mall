package com.gaogaoqwq.mall.view;

import java.util.List;

import com.gaogaoqwq.mall.entity.Good;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor
public class CustomerCartItemView {

    private Long goodId;

    private String previewImageUrl;

    private String goodName;

    private String goodDescription;

    private int stock;

    private String price;

    public static CustomerCartItemView fromGood(Good good) {
        return CustomerCartItemView.builder()
            .goodId(good.getId())
            .previewImageUrl(good.getPreviewImgUrl())
            .goodName(good.getName())
            .goodDescription(good.getDescription())
            .stock(good.getStock())
            .price(good.getPrice().toString()).build();
    }

}

