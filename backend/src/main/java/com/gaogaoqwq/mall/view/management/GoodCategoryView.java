package com.gaogaoqwq.mall.view.management;

import java.util.List;
import java.util.stream.Collectors;

import com.gaogaoqwq.mall.entity.GoodCategory;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor
public class GoodCategoryView {

    private Long id;

    private String name;

    private List<GoodSubCategoryView> subCategories;

    public static GoodCategoryView fromGoodCategory(GoodCategory category) {
        return GoodCategoryView.builder()
                .id(category.getId())
                .name(category.getName())
                .subCategories(category.getSubCategories().stream()
                        .map(GoodSubCategoryView::fromGoodSubCategory)
                        .collect(Collectors.toList()))
                .build();
    }

}
