package com.gaogaoqwq.mall.service;

import com.gaogaoqwq.mall.entity.Good;
import com.gaogaoqwq.mall.entity.User;
import com.gaogaoqwq.mall.view.CustomerCartItemView;

import java.util.List;

public interface CustomerService {

    public List<CustomerCartItemView> getCartItemsByUsername(String username);

    public void addGoodToCart(Good good, User user);
    
    public void removeGoodFromCart(Long goodId, User user);

}
