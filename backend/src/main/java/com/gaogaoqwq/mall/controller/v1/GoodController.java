package com.gaogaoqwq.mall.controller.v1;

import com.gaogaoqwq.mall.response.R;
import com.gaogaoqwq.mall.service.GoodService;
import com.gaogaoqwq.mall.view.CountView;
import com.gaogaoqwq.mall.view.GoodDetailView;
import com.gaogaoqwq.mall.view.GoodInfoView;
import com.gaogaoqwq.mall.view.GoodSwiperView;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequiredArgsConstructor
@RequestMapping(value = "/v1/good", produces = "application/json")
public class GoodController {

    final private GoodService goodService;

    @GetMapping("/list")
    public R goodList(@RequestParam int page, @RequestParam(required = false) Optional<Integer> size) {
        if (size.isEmpty()) size = Optional.of(10);
        var goods = goodService.getGoodByPage(page, size.get());
        var views = goods.stream().map(GoodInfoView::fromGood).toList();
        return R.success(views);
    }

    @GetMapping("/count")
    public R goodCount() {
        return R.success(new CountView(goodService.getGoodCount()));
    }

    @GetMapping("/swiper")
    public R goodSwiper() {
        var goodSwiper = goodService.getGoodSwiper();
        var views = goodSwiper.stream().map(GoodSwiperView::fromGoodSwiper).toList();
        return R.success(views);
    }

    @GetMapping("/detail/{id}")
    public R goodDetail(@PathVariable Long id) {
        var good = goodService.getGoodById(id);
        return good.map(value -> R.success(GoodDetailView.fromGood(value)))
                .orElseGet(() -> R.failure("商品不存在"));
    }

}
