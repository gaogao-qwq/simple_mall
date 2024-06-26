package com.gaogaoqwq.mall.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import com.gaogaoqwq.mall.entity.CartItem;

@Transactional(readOnly = true)
public interface CartItemRepository extends JpaRepository<CartItem, String> {

    @Modifying
    @Transactional
    @Query("delete from CartItem c where c.id = ?1")
    void deleteById(String id);

    @Modifying
    @Transactional
    @Query("delete from CartItem c where c.id in ?1")
    void deleteByIdIn(List<String> ids);

}
