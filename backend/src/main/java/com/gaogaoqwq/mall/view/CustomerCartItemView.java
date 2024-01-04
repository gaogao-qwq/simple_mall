package com.gaogaoqwq.mall.view;

import com.gaogaoqwq.mall.entity.CartItem;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor
public class CustomerCartItemView {

    private Long goodId;

    private String previewImgUrl;

    private String goodName;

    private String goodDescription;

    private Integer stock;

    private String price;

    private Long addDate;

    public static CustomerCartItemView fromCartItem(CartItem cartItem) {
        var good = cartItem.getGood();
        return CustomerCartItemView.builder()
            .goodId(good.getId())
            .previewImgUrl(good.getPreviewImgUrl())
            .goodName(good.getName())
            .goodDescription(good.getDescription())
            .stock(good.getStock())
            .price(good.getPrice().toString())
            .addDate(cartItem.getAddDate().toEpochMilli()).build();
    }

}

