package com.gaogaoqwq.mall.controller.v1.management;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.gaogaoqwq.mall.entity.GoodCategory;
import com.gaogaoqwq.mall.repository.GoodCategoryRepository;
import com.gaogaoqwq.mall.response.R;
import com.gaogaoqwq.mall.view.management.GoodCategoryView;

import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RestController
@RequestMapping(path = "/v1/category-management", produces = "application/json")
@ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Successful operation"),
        @ApiResponse(responseCode = "401", description = "Authentication failed")
})
public class CategoryManagementController {

    private final GoodCategoryRepository categoryRepository;

    @GetMapping("/list")
    public R categoryList() {
        List<GoodCategory> categories = categoryRepository.findAll();
        return R.successBuilder()
                .data(categories.stream()
                        .map(GoodCategoryView::fromGoodCategory)
                        .collect(Collectors.toList()))
                .build();
    }

}
