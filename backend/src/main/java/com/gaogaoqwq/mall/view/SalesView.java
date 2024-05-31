package com.gaogaoqwq.mall.view;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor
public class SalesView {

    private String date;

    private Long sales;

    public static List<SalesView> fromMap(Map<Date, Long> map) {
        DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        return map.entrySet().stream()
                .map(entry -> SalesView.builder()
                        .date(formatter.format(entry.getKey()))
                        .sales(entry.getValue())
                        .build())
                .collect(Collectors.toList());
    }

}
