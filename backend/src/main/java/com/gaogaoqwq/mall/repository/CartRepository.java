package com.gaogaoqwq.mall.repository;

import com.gaogaoqwq.mall.entity.Cart;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

public interface CartRepository extends JpaRepository<Cart, String> {

    public Optional<Cart> findUserCartByUserId(Long userId);

}
