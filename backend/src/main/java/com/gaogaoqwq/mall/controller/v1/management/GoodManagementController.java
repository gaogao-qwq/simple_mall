package com.gaogaoqwq.mall.controller.v1.management;

import com.gaogaoqwq.mall.dto.management.GoodDto;
import com.gaogaoqwq.mall.response.R;
import com.gaogaoqwq.mall.service.GoodService;
import com.gaogaoqwq.mall.view.CountView;
import com.gaogaoqwq.mall.view.SalesView;
import com.gaogaoqwq.mall.view.management.GoodInfoView;

import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.Optional;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
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

    @GetMapping("/sales")
    public R goodSales(@RequestParam(required = false) Optional<String> from,
            @RequestParam(required = false) Optional<String> to) {
        DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Optional<Date> fromInstant = Optional.empty();
        Optional<Date> toInstant = Optional.empty();
        if (from.isPresent()) {
            try {
                fromInstant = Optional.of(formatter.parse(from.get()));
            } catch (ParseException e) {
                fromInstant = Optional.empty();
            }
        }
        if (to.isPresent()) {
            try {
                toInstant = Optional.of(formatter.parse(to.get()));
            } catch (ParseException e) {
                toInstant = Optional.empty();
            }
        }
        return R.successBuilder()
                .data(SalesView.fromMap(goodService.getGoodSales(fromInstant, toInstant)))
                .build();
    }

    @GetMapping("/sales-sum")
    public R goodSalesSum(@RequestParam(required = false) Optional<String> from,
            @RequestParam(required = false) Optional<String> to) {
        DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Optional<Date> fromInstant = Optional.empty();
        Optional<Date> toInstant = Optional.empty();
        if (from.isPresent()) {
            try {
                fromInstant = Optional.of(formatter.parse(from.get()));
            } catch (ParseException e) {
                fromInstant = Optional.empty();
            }
        }
        if (to.isPresent()) {
            try {
                toInstant = Optional.of(formatter.parse(to.get()));
            } catch (ParseException e) {
                toInstant = Optional.empty();
            }
        }
        return R.successBuilder()
                .data(Map.of("sales", goodService.getGoodSalesSum(fromInstant, toInstant)))
                .build();
    }

    @GetMapping("/count")
    public R goodCount() {
        return R.successBuilder()
                .data(new CountView(goodService.getGoodCount()))
                .build();
    }

    @PostMapping("/good")
    public R addGood(@RequestBody GoodDto dto) {
        throw new UnsupportedOperationException("Unimplemented method 'addGood'");
    }

    @PutMapping("/good")
    public R updateGood(@RequestParam Long id) {
        throw new UnsupportedOperationException("Unimplemented method 'updateGood'");
    }

    @DeleteMapping("good")
    public R deleteGood(@RequestParam Long id) {
        throw new UnsupportedOperationException("Unimplemented method 'deleteGood'");
    }

}
