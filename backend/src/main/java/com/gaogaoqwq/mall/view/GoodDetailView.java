package com.gaogaoqwq.mall.view;

import com.gaogaoqwq.mall.entity.Good;
import com.gaogaoqwq.mall.entity.GoodImage;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
public class GoodDetailView {

    private Long id;

    private String name;

    private String previewImgUrl;

    private List<String> detailImgUrl;

    private String description;

    private String price;

    private int stock;

    public static GoodDetailView fromGood(Good good) {
        return GoodDetailView.builder()
                .id(good.getId())
                .name(good.getName())
                .previewImgUrl(good.getPreviewImgUrl())
                .detailImgUrl(good.getImages().stream().map(GoodImage::getImageUrl).toList())
                .description(good.getDescription())
                .price(good.getPrice().toString())
                .stock(good.getStock())
                .build();
    }

}
