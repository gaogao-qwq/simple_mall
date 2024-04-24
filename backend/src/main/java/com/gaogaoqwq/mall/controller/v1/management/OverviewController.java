package com.gaogaoqwq.mall.controller.v1.management;

import java.time.Duration;
import java.time.Instant;
import java.util.Date;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.gaogaoqwq.mall.response.R;
import com.gaogaoqwq.mall.service.GoodOrderService;
import com.gaogaoqwq.mall.view.SalesView;

import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RestController
@RequestMapping(path = "/v1/overview", produces = "application/json")
@ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Successful operation"),
        @ApiResponse(responseCode = "401", description = "Authentication failed")
})
public class OverviewController {

    private final GoodOrderService goodOrderService;

    @GetMapping("/last-months-sales")
    public R getLastMonthsSales() {
        final Date from = Date.from(Instant.now().minus(Duration.ofDays(30)));
        final Date to = Date.from(Instant.now());
        final SalesView view = SalesView.builder()
                .sales(Long.valueOf(goodOrderService.getSalesWithin(from, to)))
                .build();
        return R.successBuilder().data(view).build();
    }
}
