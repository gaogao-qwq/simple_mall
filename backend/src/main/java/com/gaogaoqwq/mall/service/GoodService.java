package com.gaogaoqwq.mall.service;

import com.gaogaoqwq.mall.entity.Good;
import com.gaogaoqwq.mall.entity.GoodSwiper;

import java.util.List;
import java.util.Optional;

public interface GoodService {

    List<Good> getGoodByPage(int page, int size);

    long getGoodCount();

    List<GoodSwiper> getGoodSwiper();

    Optional<Good> getGoodById(Long id);

}
