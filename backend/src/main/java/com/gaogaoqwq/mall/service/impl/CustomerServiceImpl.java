package com.gaogaoqwq.mall.service.impl;

import java.time.Instant;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.gaogaoqwq.mall.dto.AddressDto;
import com.gaogaoqwq.mall.entity.Address;
import com.gaogaoqwq.mall.entity.Cart;
import com.gaogaoqwq.mall.entity.CartItem;
import com.gaogaoqwq.mall.entity.Good;
import com.gaogaoqwq.mall.entity.User;
import com.gaogaoqwq.mall.exception.AddressNotFoundException;
import com.gaogaoqwq.mall.exception.CartItemNotFoundException;
import com.gaogaoqwq.mall.exception.CartNotFoundException;
import com.gaogaoqwq.mall.repository.AddressRepository;
import com.gaogaoqwq.mall.repository.CartItemRepository;
import com.gaogaoqwq.mall.repository.CartRepository;
import com.gaogaoqwq.mall.repository.UserRepository;
import com.gaogaoqwq.mall.service.CustomerService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CustomerServiceImpl implements CustomerService {

    private final CartRepository cartRepo;
    private final CartItemRepository cartItemRepo;
    private final AddressRepository addressRepo;
    private final UserRepository userRepo;

    @Override
    public List<CartItem> getCartItems(User user) {
        Cart cart = user.getCart();
        if (cart == null) {
            return List.of();
        }
        return cart.getCartItems();
    }

    @Override
    public void addGoodToCart(Good good, User user) {
        Cart cart = user.getCart();
        if (cart == null) {
            throw new CartNotFoundException(user);
        }
        cart.getCartItems().stream()
                .filter(item -> item.getGood().equals(good))
                .findFirst()
                .ifPresentOrElse(
                        filteredItem -> filteredItem.countIncrement(),
                        () -> cart.getCartItems().add(CartItem.builder()
                                .good(good)
                                .cart(cart)
                                .addDate(Instant.now())
                                .count(1).build()));
        cartRepo.save(cart);
    }

    @Override
    public void removeCartItem(User user, String cartItemId) {
        Cart cart = user.getCart();
        if (cart == null) {
            throw new CartNotFoundException(user);
        }
        List<CartItem> cartItems = cart.getCartItems().stream()
                .filter(e -> e.getId().equals(cartItemId)).toList();
        if (cartItems.isEmpty()) {
            throw new CartItemNotFoundException(cartItemId);
        }
        cartItemRepo.deleteById(cartItemId);
    }

    @Override
    public void setCartItemCount(String cartItemId, Integer count, User user) {
        Optional<CartItem> cartItemOpt = cartItemRepo.findById(cartItemId);
        cartItemOpt.ifPresent(e -> {
            if (!cartItemOpt.get().getCart().getUser().equals(user)) {
                throw new CartItemNotFoundException(cartItemId);
            }
            cartItemOpt.get().setCount(count <= 0 ? 1 : count);
            cartItemRepo.save(cartItemOpt.get());
        });
    }

    @Override
    public void addAddress(User user, AddressDto addressDto) {
        Address addr = Address.fromAddressDto(addressDto);
        addr.setUser(user);
        if (user.getDefaultAddress() == null) {
            addr.setDefaultUser(user);
        }
        addressRepo.save(addr);
    }

    @Override
    public void removeAddress(User user, String addressId) {
        List<Address> addresses = user.getAddresses().stream()
                .filter(e -> e.getId().equals(addressId))
                .toList();
        if (addresses.isEmpty()) {
            throw new AddressNotFoundException(addressId);
        }
        if (user.getDefaultAddress() != null) {
            if (user.getAddresses().size() > 1) {
                Address addr = user.getAddresses().stream()
                        .filter(e -> !e.getId().equals(addressId))
                        .toList().get(0);
                user.setDefaultAddress(addr);
            } else {
                user.setDefaultAddress(null);
            }
        }
        userRepo.save(user);
        addressRepo.deleteById(addressId);
    }

    @Override
    public void setDefaultAddress(User user, String addressId) {
        List<Address> addresses = user.getAddresses().stream()
                .filter(e -> e.getId().equals(addressId)).toList();
        if (addresses.isEmpty()) {
            throw new AddressNotFoundException(addressId);
        }
        user.setDefaultAddress(addresses.get(0));
        userRepo.save(user);
    }

    @Override
    public void removeAddresses(User user, List<String> addressIds) {
        List<String> userAddressIds = user.getAddresses().stream()
                .filter(e -> addressIds.contains(e.getId()))
                .map(e -> e.getId()).toList();
        if (userAddressIds.contains(user.getDefaultAddress().getId())) {
            if (user.getAddresses().size() > userAddressIds.size()) {
                Address addr = user.getAddresses().stream()
                        .filter(e -> !userAddressIds.contains(e.getId()))
                        .toList().get(0);
                user.setDefaultAddress(addr);
            } else {
                user.setDefaultAddress(null);
            }
        }
        if (userAddressIds.isEmpty()) {
            throw new AddressNotFoundException(addressIds);
        }
        userRepo.save(user);
        addressRepo.deleteByIdIn(userAddressIds);
    }

}
