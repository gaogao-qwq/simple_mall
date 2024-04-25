package com.gaogaoqwq.mall.service;

import java.util.List;

import com.gaogaoqwq.mall.dto.AddressDto;
import com.gaogaoqwq.mall.entity.CartItem;
import com.gaogaoqwq.mall.entity.Good;
import com.gaogaoqwq.mall.entity.GoodOrder;
import com.gaogaoqwq.mall.entity.User;

public interface CustomerService {

    public List<CartItem> getCartItems(User user);

    public void setCartItemCount(String cartItemId, Integer count, User user);

    public void addGoodToCart(Good good, User user);

    public void removeCartItem(User user, String cartItemId);

    public void addAddress(User user, AddressDto addressDto);

    public void removeAddress(User user, String addressId);

    public void setDefaultAddress(User user, String addressId);

    public void removeAddresses(User user, List<String> addressIds);

    public GoodOrder getGoodOrderById(User user, String id);

}
