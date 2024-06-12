package com.gaogaoqwq.mall.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.gaogaoqwq.mall.entity.Good;
import com.gaogaoqwq.mall.entity.GoodOrder;
import com.gaogaoqwq.mall.entity.GoodSwiper;
import com.gaogaoqwq.mall.exception.DateConflictException;
import com.gaogaoqwq.mall.repository.GoodRepository;
import com.gaogaoqwq.mall.repository.GoodSwiperRepository;
import com.gaogaoqwq.mall.service.GoodService;

import lombok.RequiredArgsConstructor;

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

    @Override
    public Long getGoodSalesSum(Optional<Date> from, Optional<Date> to) {
        Stream<List<GoodOrder>> orderListStream = goodRepo.findAll().stream().map(Good::getGoodOrders);
        if (from.isEmpty() && to.isEmpty()) {
            return orderListStream
                    .map(orders -> orders.stream()
                            .filter(order -> order.getState().isCountedSales()))
                    .mapToLong(orders -> orders.count()).sum();
        } else if (from.isEmpty() && to.isPresent()) {
            return orderListStream
                    .map(orders -> orders.stream()
                            .filter(order -> order.getState().isCountedSales())
                            .filter(order -> order.getCreateDate().compareTo(to.get()) <= 0))
                    .mapToLong(orders -> orders.count()).sum();
        } else if (from.isPresent() && to.isEmpty()) {
            return orderListStream
                    .map(orders -> orders.stream()
                            .filter(order -> order.getState().isCountedSales())
                            .filter(order -> order.getCreateDate().compareTo(from.get()) >= 0))
                    .mapToLong(orders -> orders.count()).sum();
        } else if (from.isPresent() && to.isPresent()) {
            if (from.get().compareTo(to.get()) > 0) {
                throw new DateConflictException(from.get(), to.get());
            }
            return orderListStream
                    .map(orders -> orders.stream()
                            .filter(order -> order.getState().isCountedSales())
                            .filter(order -> order.getCreateDate().compareTo(from.get()) >= 0)
                            .filter(order -> order.getCreateDate().compareTo(to.get()) <= 0))
                    .mapToLong(orders -> orders.count()).sum();
        }
        return Long.valueOf(0);
    }

    @Override
    public Map<Date, Long> getGoodSales(Optional<Date> from, Optional<Date> to) {
        Stream<GoodOrder> orderStream = goodRepo.findAll().stream()
                .map(Good::getGoodOrders).flatMap(List::stream);
        if (from.isEmpty() && to.isEmpty()) {
            return orderStream
                    .filter(order -> order.getState().isCountedSales())
                    .collect(Collectors.toMap(
                            order -> order.getCreateDate(),
                            order -> 1L,
                            Long::sum));
        } else if (from.isEmpty() && to.isPresent()) {
            return orderStream
                    .filter(order -> order.getState().isCountedSales())
                    .filter(order -> order.getCreateDate().compareTo(to.get()) <= 0)
                    .collect(Collectors.toMap(
                            order -> order.getCreateDate(),
                            order -> 1L,
                            Long::sum));
        } else if (from.isPresent() && to.isEmpty()) {
            return orderStream
                    .filter(order -> order.getState().isCountedSales())
                    .filter(order -> order.getCreateDate().compareTo(from.get()) >= 0)
                    .collect(Collectors.toMap(
                            order -> order.getCreateDate(),
                            order -> 1L,
                            Long::sum));
        } else if (from.isPresent() && to.isPresent()) {
            return orderStream
                    .filter(order -> order.getState().isCountedSales())
                    .filter(order -> order.getCreateDate().compareTo(from.get()) >= 0)
                    .filter(order -> order.getCreateDate().compareTo(to.get()) <= 0)
                    .collect(Collectors.toMap(
                            order -> order.getCreateDate(),
                            order -> 1L,
                            Long::sum));
        }
        return Map.of();
    }

    @Override
    public List<Good> fuzzySearchGoodName(String name) {
        return goodRepo.findByNameContaining(name);
    }

    @Override
    public void addGood(Good good) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'addGood'");
    }

    @Override
    public void updateGood(Good good) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'updateGood'");
    }

    @Override
    public void removeGood(Good good) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'removeGood'");
    }

}
