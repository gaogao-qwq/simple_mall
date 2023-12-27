package com.gaogaoqwq.mall.view;

import com.gaogaoqwq.mall.entity.GoodSwiper;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor
public class GoodSwiperView {

    private String imgUrl;

    private Long goodId;

    public static GoodSwiperView fromGoodSwiper(GoodSwiper swiper) {
        return GoodSwiperView.builder()
                .imgUrl(swiper.getSwiperImgUrl())
                .goodId(swiper.getGood().getId())
                .build();
    }

}
