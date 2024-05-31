package com.gaogaoqwq.mall.extension;

import java.util.Optional;

public class OptionalExtension {

    public static <T> Optional<T> isEmptyOr(Optional<T> opt, T ifEmpty) {
        return opt.isEmpty() ? Optional.ofNullable(ifEmpty) : opt;
    }

}
