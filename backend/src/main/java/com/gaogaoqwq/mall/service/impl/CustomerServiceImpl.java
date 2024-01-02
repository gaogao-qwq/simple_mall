package com.gaogaoqwq.mall.service.impl;

import com.gaogaoqwq.mall.view.CustomerCartItemView;
import com.gaogaoqwq.mall.entity.Good;
import com.gaogaoqwq.mall.entity.User;
import com.gaogaoqwq.mall.entity.UserCart;
import com.gaogaoqwq.mall.repository.UserCartRepository;
import com.gaogaoqwq.mall.repository.UserRepository;
import com.gaogaoqwq.mall.service.CustomerService;
import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CustomerServiceImpl implements CustomerService {

    private final UserRepository userRepo;
    private final UserCartRepository userCartRepo;

    @Override
    public List<CustomerCartItemView> getCartItemsByUsername(String username) {
        Optional<User> userOpt = userRepo.findUserByUsername(username);
        if (userOpt.isEmpty() || !userOpt.get().isEnabled()) return List.of();
        final User user = userOpt.get();
        final Optional<UserCart> userCartOpt = userCartRepo.findUserCartByUserId(user.getId());
        if (userCartOpt.isEmpty()) return List.of();
        return userCartOpt.get().getGoods().stream().map(CustomerCartItemView::fromGood).toList();
    }

    @Override
    public void addGoodToCart(Good good, User user) {
        Optional<UserCart> userCartOpt = userCartRepo.findUserCartByUserId(user.getId());
        if (userCartOpt.isEmpty()) return;
        final UserCart userCart = userCartOpt.get();
        userCart.getGoods().add(good);
        userCartRepo.save(userCart);
    }

    @Override
    public void removeGoodFromCart(Long goodId, User user) {
        Optional<UserCart> userCartOpt = userCartRepo.findUserCartByUserId(user.getId());
        if (userCartOpt.isEmpty()) return;
        final UserCart userCart = userCartOpt.get();
        userCart.getGoods().removeIf(g -> g.getId().equals(goodId));
        userCartRepo.save(userCart);
    }

}
