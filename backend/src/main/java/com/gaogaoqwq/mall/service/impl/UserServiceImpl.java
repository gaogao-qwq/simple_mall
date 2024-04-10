package com.gaogaoqwq.mall.service.impl;

import com.gaogaoqwq.mall.entity.User;
import com.gaogaoqwq.mall.enums.ErrorMessage;
import com.gaogaoqwq.mall.repository.UserRepository;
import com.gaogaoqwq.mall.service.UserService;

import lombok.RequiredArgsConstructor;

import java.util.List;

import org.springframework.data.domain.PageRequest;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepository userRepo;

    @Override
    public UserDetails loadUserByUsername(String username)
            throws UsernameNotFoundException {
        return userRepo.findUserByUsername(username).orElseThrow(() ->
                new UsernameNotFoundException(
                    ErrorMessage.USERNAME_NOT_EXIST));
    }

    public Long getUserCount() {
        return userRepo.count();
    }

    @Override
    public List<User> getUserListByPage(int page, int size) {
        return userRepo.findAll(PageRequest.of(page, size)).getContent();
    }

}
