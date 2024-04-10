package com.gaogaoqwq.mall.view.management;

import com.gaogaoqwq.mall.entity.Good;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor
public class GoodInfoView {

    private Long id;

    private String name;

    private String price;

    private String imgUrl;

    private Integer stock;

    public static GoodInfoView fromGood(Good good) {
        return GoodInfoView.builder()
                .id(good.getId())
                .name(good.getName())
                .imgUrl(good.getPreviewImgUrl())
                .price(good.getPrice().toString())
                .stock(good.getStock())
                .build();
    }

}
