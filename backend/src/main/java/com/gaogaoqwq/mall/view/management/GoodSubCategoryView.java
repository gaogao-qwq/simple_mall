package com.gaogaoqwq.mall.view.management;

import com.gaogaoqwq.mall.entity.GoodSubCategory;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor
public class GoodSubCategoryView {

    private Long id;

    private String name;

    public static GoodSubCategoryView fromGoodSubCategory(GoodSubCategory goodSubCategory) {
        return GoodSubCategoryView.builder()
                .id(goodSubCategory.getId())
                .name(goodSubCategory.getName())
                .build();
    }

}
