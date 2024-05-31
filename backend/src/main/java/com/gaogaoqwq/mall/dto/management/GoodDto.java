package com.gaogaoqwq.mall.dto.management;

import java.math.BigDecimal;
import java.util.List;

import com.gaogaoqwq.mall.entity.Good;
import com.gaogaoqwq.mall.entity.GoodImage;
import com.gaogaoqwq.mall.entity.GoodSubCategory;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@AllArgsConstructor
@Builder
public class GoodDto {

    private String name;

    private String description;

    private BigDecimal price;

    private Integer purchaseLimit;

    private Integer stock;

    private String previewImgUrl;

    private GoodSubCategory subCategory;

    private List<GoodImage> images;

    public Good toGood() {
        return Good.builder().build();
    }

}
