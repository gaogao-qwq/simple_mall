package com.gaogaoqwq.mall.service;

import com.gaogaoqwq.mall.entity.Good;
import com.gaogaoqwq.mall.entity.GoodSwiper;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;

public interface GoodService {

    void addGood(Good good);

    List<Good> getGoodByPage(int page, int size);

    long getGoodCount();

    List<GoodSwiper> getGoodSwiper();

    Optional<Good> getGoodById(Long id);

    Long getGoodSalesSum(Optional<Date> from, Optional<Date> to);

    Map<Date, Long> getGoodSales(Optional<Date> from, Optional<Date> to);

    void updateGood(Good good);

    void removeGood(Good good);

}
