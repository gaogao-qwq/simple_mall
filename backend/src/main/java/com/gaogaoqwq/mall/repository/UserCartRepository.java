package com.gaogaoqwq.mall.repository;

import com.gaogaoqwq.mall.entity.UserCart;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

public interface UserCartRepository extends JpaRepository<UserCart, String> {

    public Optional<UserCart> findUserCartByUserId(Long userId);

}
