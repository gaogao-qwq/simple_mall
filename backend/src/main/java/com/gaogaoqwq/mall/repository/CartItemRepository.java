package com.gaogaoqwq.mall.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.gaogaoqwq.mall.entity.CartItem;

public interface CartItemRepository extends JpaRepository<CartItem, String> {}
