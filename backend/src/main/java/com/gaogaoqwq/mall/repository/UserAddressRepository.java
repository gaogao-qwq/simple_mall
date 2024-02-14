package com.gaogaoqwq.mall.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.gaogaoqwq.mall.entity.Address;

public interface UserAddressRepository extends JpaRepository<Address, String> {
}
