package com.gaogaoqwq.mall.controller.v1;

import java.util.List;
import java.util.Optional;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gaogaoqwq.mall.dto.AddressDto;
import com.gaogaoqwq.mall.entity.CartItem;
import com.gaogaoqwq.mall.entity.Good;
import com.gaogaoqwq.mall.entity.GoodOrder;
import com.gaogaoqwq.mall.entity.User;
import com.gaogaoqwq.mall.exception.GoodNotFoundException;
import com.gaogaoqwq.mall.response.R;
import com.gaogaoqwq.mall.service.CustomerService;
import com.gaogaoqwq.mall.service.GoodService;
import com.gaogaoqwq.mall.service.UserService;
import com.gaogaoqwq.mall.service.impl.MinioServiceImpl;
import com.gaogaoqwq.mall.view.AddressView;
import com.gaogaoqwq.mall.view.CartItemView;
import com.gaogaoqwq.mall.view.GoodOrderDetailView;
import com.gaogaoqwq.mall.view.GoodOrderInfoView;

import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping(value = "/v1/customer", produces = "application/json")
@ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Successful operation"),
        @ApiResponse(responseCode = "401", description = "Authentication failed")
})
public class CustomerController {

    final private CustomerService customerService;
    final private GoodService goodService;
    final private UserService userService;
    final private MinioServiceImpl minioService;

    @GetMapping("/cart")
    public R getCartItems() {
        final String username = SecurityContextHolder.getContext().getAuthentication().getName();
        final User user = (User) userService.loadUserByUsername(username);
        List<CartItem> cartItems = customerService.getCartItems(user);

        List<CartItemView> views = cartItems.stream()
                .map(CartItemView::fromCartItem).toList();
        views = views.stream().map(e -> {
            try {
                e.setPreviewImgUrl(minioService.getObjectUrl(e.getPreviewImgUrl()));
            } catch (Exception ex) {
                ex.printStackTrace();
                e.setPreviewImgUrl(String.valueOf(""));
            }
            return e;
        }).toList();

        return R.successBuilder().data(views).build();
    }

    @GetMapping("/addresses")
    public R getAddresses() {
        final String username = SecurityContextHolder.getContext().getAuthentication().getName();
        final User user = (User) userService.loadUserByUsername(username);
        List<AddressView> views = user.getAddresses().stream()
                .map(AddressView::fromAddress).toList();
        return R.successBuilder().data(views).build();
    }

    @GetMapping("/default-address")
    public R getDefaultAddress() {
        final String username = SecurityContextHolder.getContext().getAuthentication().getName();
        final User user = (User) userService.loadUserByUsername(username);
        AddressView view = AddressView.fromAddress(user.getDefaultAddress());
        return R.successBuilder().data(view).build();
    }

    @GetMapping("/orders")
    public R getOrders() {
        final String username = SecurityContextHolder.getContext().getAuthentication().getName();
        final User user = (User) userService.loadUserByUsername(username);
        List<GoodOrderInfoView> views = user.getGoodOrders().stream()
                .map(GoodOrderInfoView::fromGoodOrder).toList();
        return R.successBuilder().data(views).build();
    }

    @GetMapping("/order/{id}")
    public R getOrder(@PathVariable String id) {
        final String username = SecurityContextHolder.getContext().getAuthentication().getName();
        final User user = (User) userService.loadUserByUsername(username);
        final GoodOrder order = customerService.getGoodOrderById(user, id);
        return R.successBuilder().data(GoodOrderDetailView.fromGoodOrder(order)).build();
    }

    @PutMapping("/cart")
    public R addGoodToCart(@RequestParam(name = "good_id") Long goodId) {
        final String username = SecurityContextHolder.getContext().getAuthentication().getName();
        final User user = (User) userService.loadUserByUsername(username);
        Optional<Good> goodOpt = goodService.getGoodById(goodId);
        if (goodOpt.isEmpty()) {
            throw new GoodNotFoundException(goodId);
        }
        customerService.addGoodToCart(goodOpt.get(), user);
        return R.successBuilder().build();
    }

    @PutMapping("/cart-item/{id}")
    public R setCartItemCount(@PathVariable String id, @RequestParam(name = "count") Integer count) {
        final String username = SecurityContextHolder.getContext().getAuthentication().getName();
        final User user = (User) userService.loadUserByUsername(username);
        customerService.setCartItemCount(id, count, user);
        return R.successBuilder().build();
    }

    @PutMapping("/default-address")
    public R setDefaultAddress(@RequestParam(name = "address_id") String addressId) {
        final String username = SecurityContextHolder.getContext().getAuthentication().getName();
        final User user = (User) userService.loadUserByUsername(username);
        customerService.setDefaultAddress(user, addressId);
        return R.successBuilder().build();
    }

    @PostMapping("/address")
    public R addAddress(@RequestBody AddressDto dto) {
        final String username = SecurityContextHolder.getContext().getAuthentication().getName();
        final User user = (User) userService.loadUserByUsername(username);
        customerService.addAddress(user, dto);
        return R.successBuilder().build();
    }

    @PostMapping("/address/delete")
    public R removeAddresses(@RequestBody List<String> addressIds) {
        final String username = SecurityContextHolder.getContext().getAuthentication().getName();
        final User user = (User) userService.loadUserByUsername(username);
        customerService.removeAddresses(user, addressIds);
        return R.successBuilder().build();
    }

    @DeleteMapping("/cart")
    public R RemoveCartItem(@RequestParam(name = "cart_item_id") String cartItemId) {
        final String username = SecurityContextHolder.getContext().getAuthentication().getName();
        final User user = (User) userService.loadUserByUsername(username);
        customerService.removeCartItem(user, cartItemId);
        return R.successBuilder().build();
    }

    @DeleteMapping("/address")
    public R removeAddress(@RequestParam(name = "address_id") String addressId) {
        final String username = SecurityContextHolder.getContext().getAuthentication().getName();
        final User user = (User) userService.loadUserByUsername(username);
        customerService.removeAddress(user, addressId);
        return R.successBuilder().build();
    }

}
