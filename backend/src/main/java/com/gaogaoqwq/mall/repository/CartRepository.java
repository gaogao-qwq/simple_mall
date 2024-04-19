package com.gaogaoqwq.mall.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.gaogaoqwq.mall.entity.Cart;

public interface CartRepository extends JpaRepository<Cart, String> {
}
