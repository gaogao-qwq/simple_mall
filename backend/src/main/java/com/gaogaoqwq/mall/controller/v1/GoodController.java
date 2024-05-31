package com.gaogaoqwq.mall.controller.v1;

import com.gaogaoqwq.mall.entity.Good;
import com.gaogaoqwq.mall.entity.GoodSwiper;
import com.gaogaoqwq.mall.enums.ErrorMessage;
import com.gaogaoqwq.mall.extension.OptionalExtension;
import com.gaogaoqwq.mall.response.R;
import com.gaogaoqwq.mall.service.GoodService;
import com.gaogaoqwq.mall.service.impl.MinioServiceImpl;
import com.gaogaoqwq.mall.view.CountView;
import com.gaogaoqwq.mall.view.GoodDetailView;
import com.gaogaoqwq.mall.view.GoodInfoView;
import com.gaogaoqwq.mall.view.GoodSwiperView;
import lombok.RequiredArgsConstructor;
import lombok.experimental.ExtensionMethod;

import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@ExtensionMethod(OptionalExtension.class)
@RestController
@RequiredArgsConstructor
@RequestMapping(value = "/v1/good", produces = "application/json")
public class GoodController {

    final private GoodService goodService;
    final private MinioServiceImpl minioService;

    @GetMapping("/list")
    public R goodList(@RequestParam int page,
            @RequestParam(required = false) Optional<Integer> size) {
        size = size.isEmptyOr(10);
        List<Good> goods = goodService.getGoodByPage(page, size.get());

        List<GoodInfoView> views = goods.stream()
                .map(GoodInfoView::fromGood)
                .toList();
        views = views.stream().map(e -> {
            try {
                e.setImgUrl(minioService.getObjectUrl(e.getImgUrl()));
            } catch (Exception ex) {
                ex.printStackTrace();
                e.setImgUrl(String.valueOf(""));
            }
            return e;
        }).toList();

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

    @GetMapping("/swiper")
    public R goodSwiper() {
        List<GoodSwiper> goodSwiper = goodService.getGoodSwiper();
        List<GoodSwiperView> views = goodSwiper.stream()
                .map(GoodSwiperView::fromGoodSwiper)
                .toList();

        views = views.stream().map(e -> {
            try {
                e.setImgUrl(minioService.getObjectUrl(e.getImgUrl()));
            } catch (Exception ex) {
                ex.printStackTrace();
                e.setImgUrl(String.valueOf(""));
            }
            return e;
        }).toList();

        return R.successBuilder()
                .data(views)
                .build();
    }

    @GetMapping("/detail/{id}")
    public R goodDetail(@PathVariable Long id) {
        Optional<Good> good = goodService.getGoodById(id);
        if (good.isEmpty()) {
            return R.failureBuilder()
                    .message(ErrorMessage.GOOD_NOT_EXIST)
                    .build();
        }
        GoodDetailView view = GoodDetailView.fromGood(good.get());

        try {
            view.setPreviewImgUrl(minioService.getObjectUrl(view.getPreviewImgUrl()));
            view.setDetailImgUrl(view.getDetailImgUrl().stream()
                    .map(e -> minioService.getObjectUrl(e))
                    .toList());
        } catch (Exception ex) {
            ex.printStackTrace();
            view.setPreviewImgUrl(String.valueOf(""));
            view.setDetailImgUrl(view.getDetailImgUrl().stream()
                    .map(e -> String.valueOf(""))
                    .toList());
        }

        return R.successBuilder()
                .data(view)
                .build();
    }

}
