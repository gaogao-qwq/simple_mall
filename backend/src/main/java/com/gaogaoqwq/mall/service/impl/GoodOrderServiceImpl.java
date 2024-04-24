package com.gaogaoqwq.mall.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;

import com.gaogaoqwq.mall.entity.Good;
import com.gaogaoqwq.mall.entity.GoodOrder;
import com.gaogaoqwq.mall.entity.User;
import com.gaogaoqwq.mall.repository.GoodOrderRepository;
import com.gaogaoqwq.mall.service.GoodOrderService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
class GoodOrderServiceImpl implements GoodOrderService {

    private final GoodOrderRepository goodOrderRepo;

    @Override
    public void createOrders(User user, List<Good> goods) {
        throw new UnsupportedOperationException("Unimplemented method 'createOrders'");
    }

    @Override
    public List<GoodOrder> getOrdersWithin(Date from, Date to) {
        return goodOrderRepo.findByCreateDateBetween(from, to);
    }

    @Override
    public Integer getSalesWithin(Date from, Date to) {
        List<GoodOrder> orders = goodOrderRepo.findByCreateDateBetween(from, to);
        return orders.stream()
                .filter(e -> e.getState().isCountedSales())
                .toList().size();
    }

}
