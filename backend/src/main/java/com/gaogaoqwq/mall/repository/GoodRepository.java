package com.gaogaoqwq.mall.repository;

import com.gaogaoqwq.mall.entity.Good;
import org.hibernate.query.Page;
import org.springframework.data.jpa.repository.JpaRepository;

public interface GoodRepository extends JpaRepository<Good, Long> {}
