package com.gaogaoqwq.mall.service;

import java.util.List;

import org.springframework.security.core.userdetails.UserDetailsService;

import com.gaogaoqwq.mall.entity.User;

public interface UserService extends UserDetailsService {

    Long getUserCount();

    List<User> getUserListByPage(int page, int size);

}
