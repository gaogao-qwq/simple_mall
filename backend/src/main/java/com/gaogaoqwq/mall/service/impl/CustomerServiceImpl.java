package com.gaogaoqwq.mall.service.impl;

import com.gaogaoqwq.mall.view.CartItemView;
import com.gaogaoqwq.mall.entity.Good;
import com.gaogaoqwq.mall.entity.User;
import com.gaogaoqwq.mall.entity.Cart;
import com.gaogaoqwq.mall.entity.CartItem;
import com.gaogaoqwq.mall.repository.CartItemRepository;
import com.gaogaoqwq.mall.repository.CartRepository;
import com.gaogaoqwq.mall.repository.UserRepository;
import com.gaogaoqwq.mall.service.CustomerService;
import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CustomerServiceImpl implements CustomerService {

    private final UserRepository userRepo;
    private final CartRepository cartRepo;
    private final CartItemRepository cartItemRepo;

    @Override
    public List<CartItemView> getCartItemsByUsername(String username) {
        Optional<User> userOpt = userRepo.findUserByUsername(username);
        if (userOpt.isEmpty() || !userOpt.get().isEnabled()) return List.of();
        final User user = userOpt.get();
        final Optional<Cart> userCartOpt = cartRepo.findUserCartByUserId(user.getId());
        if (userCartOpt.isEmpty()) return List.of();
        return userCartOpt.get().getCartItems().stream().map(CartItemView::fromCartItem).toList();
    }

    @Override
    public void addGoodToCart(Good good, User user) {
        Optional<Cart> cartOpt = cartRepo.findUserCartByUserId(user.getId());
        if (cartOpt.isEmpty()) return;
        final var cart = cartOpt.get();
        cart.getCartItems().stream()
            .filter(item -> item.getGood().equals(good))
            .findFirst()
            .ifPresentOrElse(
                filteredItem -> filteredItem.countIncrement(),
                () -> cart.getCartItems().add(CartItem.builder()
                    .good(good)
                    .cart(cart)
                    .addDate(Instant.now())
                    .count(1).build())
            );
        cartRepo.save(cart);
    }

    @Override
    public void removeGoodFromCart(Long goodId, User user) {
        Optional<Cart> cartOpt = cartRepo.findUserCartByUserId(user.getId());
        if (cartOpt.isEmpty()) return;
        final Cart cart = cartOpt.get();
        cart.getCartItems().removeIf(e -> e.getGood().getId().equals(goodId));
        cartRepo.save(cart);
    }

    @Override
    public void setCartItemCountById(String id, Integer count, User user) {
        Optional<CartItem> cartItemOpt =cartItemRepo.findById(id);
        cartItemOpt.ifPresent(e -> {
            if (!cartItemOpt.get().getCart().getUser().equals(user)) return;
            cartItemOpt.get().setCount(count);
            cartItemRepo.save(cartItemOpt.get());
        });
    }

}
