package com.gaogaoqwq.mall.enums;

public enum OrderState {

    AWAIT_PAYMENT("等待付款"),

    AWAIT_DELIVERY("等待发货"),

    AWAIT_LOGISTIC("等待物流"),

    AWAIT_RECEIPT("等待收货"),

    ORDER_COMPLETE("交易完成");

    private final String name;

    OrderState(String name) {
        this.name = name;
    }

}
