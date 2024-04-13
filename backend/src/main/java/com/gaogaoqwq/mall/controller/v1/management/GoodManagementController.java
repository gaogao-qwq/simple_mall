package com.gaogaoqwq.mall.controller.v1.management;

import com.gaogaoqwq.mall.response.R;
import com.gaogaoqwq.mall.service.GoodService;
import com.gaogaoqwq.mall.view.CountView;
import com.gaogaoqwq.mall.view.management.GoodInfoView;

import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;

import java.util.Optional;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
@RequestMapping(path = "/v1/good-management", produces = "application/json")
@ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Successful operation"),
        @ApiResponse(responseCode = "401", description = "Authentication failed")
})
public class GoodManagementController {

    private final GoodService goodService;

    @GetMapping("/list")
    public R goodList(@RequestParam int page,
            @RequestParam(required = false) Optional<Integer> size) {
        if (size.isEmpty())
            size = Optional.of(10);
        var goods = goodService.getGoodByPage(page, size.get());

        var views = goods.stream()
                .map(GoodInfoView::fromGood).toList();
        return R.successBuilder()
                .data(views)
                .build();
    }

    @GetMapping("/count")
    public R goodCount() {
        return R.successBuilder()
                .data(new CountView(goodService.getGoodCount()))
                .build();
    }

}
