package com.gaogaoqwq.mall.repository;

import com.gaogaoqwq.mall.entity.Good;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface GoodRepository extends JpaRepository<Good, Long> {

    List<Good> findByNameContaining(String str);

}
