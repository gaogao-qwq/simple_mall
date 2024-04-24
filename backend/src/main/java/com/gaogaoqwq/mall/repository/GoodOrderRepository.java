package com.gaogaoqwq.mall.repository;

import com.gaogaoqwq.mall.entity.GoodOrder;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Date;

public interface GoodOrderRepository extends JpaRepository<GoodOrder, String> {

    List<GoodOrder> findByCreateDateBetween(Date from, Date to);

}
