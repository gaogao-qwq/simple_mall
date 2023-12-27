package com.gaogaoqwq.mall.service.impl;

import com.gaogaoqwq.mall.entity.Good;
import com.gaogaoqwq.mall.entity.GoodSwiper;
import com.gaogaoqwq.mall.repository.GoodRepository;
import com.gaogaoqwq.mall.repository.GoodSwiperRepository;
import com.gaogaoqwq.mall.service.GoodService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class GoodServiceImpl implements GoodService {

    private final GoodRepository goodRepo;
    private final GoodSwiperRepository goodSwiperRepo;

    public List<Good> getGoodByPage(int page, int size) {
        var goods = goodRepo.findAll(PageRequest.of(page, size));
        return goods.getContent();
    }

    public long getGoodCount() {
        return goodRepo.count();
    }

    public List<GoodSwiper> getGoodSwiper() {
        return goodSwiperRepo.findAll();
    }

    @Override
    public Optional<Good> getGoodById(Long id) {
        return goodRepo.findById(id);
    }

}
