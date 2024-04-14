package com.gaogaoqwq.mall.controller.v1;

import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;

import java.util.List;
import java.util.Optional;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gaogaoqwq.mall.entity.CartItem;
import com.gaogaoqwq.mall.entity.Good;
import com.gaogaoqwq.mall.entity.User;
import com.gaogaoqwq.mall.enums.ErrorMessage;
import com.gaogaoqwq.mall.response.R;
import com.gaogaoqwq.mall.service.CustomerService;
import com.gaogaoqwq.mall.service.GoodService;
import com.gaogaoqwq.mall.service.UserService;
import com.gaogaoqwq.mall.service.impl.MinioServiceImpl;
import com.gaogaoqwq.mall.view.CartItemView;

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
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        List<CartItem> cartItems = customerService.getCartItemsByUsername(username);

        List<CartItemView> views = cartItems.stream()
                .map(CartItemView::fromCartItem)
                .toList();
        views = views.stream().map(e -> {
            try {
                e.setPreviewImgUrl(minioService.getObjectUrl(e.getPreviewImgUrl()));
            } catch (Exception ex) {
                ex.printStackTrace();
                e.setPreviewImgUrl(String.valueOf(""));
            }
            return e;
        }).toList();

        return R.successBuilder()
                .data(views)
                .build();
    }

    @PutMapping("/cart")
    public R addGoodToCart(@RequestParam(name = "good_id") Long goodId) {
        final String username = SecurityContextHolder.getContext().getAuthentication().getName();
        final User user = (User) userService.loadUserByUsername(username);
        Optional<Good> goodOpt = goodService.getGoodById(goodId);
        if (goodOpt.isEmpty()) {
            return R.successBuilder().success(false).message(ErrorMessage.GOOD_NOT_EXIST).build();
        }
        customerService.addGoodToCart(goodOpt.get(), user);
        return R.successBuilder().build();
    }

    @PutMapping("/cart-item/{id}")
    public R setCartItemCount(@PathVariable String id, @RequestParam(name = "count") Integer count) {
        final String username = SecurityContextHolder.getContext().getAuthentication().getName();
        final User user = (User) userService.loadUserByUsername(username);
        customerService.setCartItemCountById(id, count, user);
        return R.successBuilder().build();
    }

    @DeleteMapping("/cart")
    public R removeGoodFromCart(@RequestParam(name = "good_id") Long goodId) {
        final String username = SecurityContextHolder.getContext().getAuthentication().getName();
        final User user = (User) userService.loadUserByUsername(username);
        customerService.removeGoodFromCart(goodId, user);
        return R.successBuilder().build();
    }

}
