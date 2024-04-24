package com.gaogaoqwq.mall.service;

import java.util.List;
import java.util.Date;

import com.gaogaoqwq.mall.entity.Good;
import com.gaogaoqwq.mall.entity.GoodOrder;
import com.gaogaoqwq.mall.entity.User;

public interface GoodOrderService {

    public void createOrders(User user, List<Good> goods);

    public List<GoodOrder> getOrdersWithin(Date from, Date to);

    public Integer getSalesWithin(Date from, Date to);

}

