package com.gaogaoqwq.mall.view;

import com.gaogaoqwq.mall.entity.CartItem;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor
public class CartItemView {

    private String id;

    private Long goodId;

    private String previewImgUrl;

    private String goodName;

    private String goodDescription;

    private Integer stock;

    private String price;

    private Integer purchaseLimit;

    private Integer count;

    private Long addDate;

    public static CartItemView fromCartItem(CartItem cartItem) {
        var good = cartItem.getGood();
        return CartItemView.builder()
            .id(cartItem.getId())
            .goodId(good.getId())
            .previewImgUrl(good.getPreviewImgUrl())
            .goodName(good.getName())
            .goodDescription(good.getDescription())
            .stock(good.getStock())
            .price(good.getPrice().toString())
            .purchaseLimit(good.getPurchaseLimit())
            .count(cartItem.getCount())
            .addDate(cartItem.getAddDate().toEpochMilli()).build();
    }

}

