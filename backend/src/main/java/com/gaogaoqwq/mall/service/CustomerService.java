package com.gaogaoqwq.mall.service;

import com.gaogaoqwq.mall.entity.Good;
import com.gaogaoqwq.mall.entity.User;
import com.gaogaoqwq.mall.view.CartItemView;

import java.util.List;

public interface CustomerService {

    public List<CartItemView> getCartItemsByUsername(String username);

    public void setCartItemCountById(String id, Integer count, User user);

    public void addGoodToCart(Good good, User user);
    
    public void removeGoodFromCart(Long goodId, User user);

}
