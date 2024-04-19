package com.gaogaoqwq.mall.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import com.gaogaoqwq.mall.entity.Address;

@Transactional(readOnly = true)
public interface AddressRepository extends JpaRepository<Address, String> {

    @Modifying
    @Transactional
    @Query("delete from Address a where a.id = ?1")
    void deleteById(String id);

    @Modifying
    @Transactional
    @Query("delete from Address a where a.id in ?1")
    void deleteByIdIn(List<String> ids);

}
