package com.gaogaoqwq.mall.entity;

import com.gaogaoqwq.mall.enums.OrderState;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.Instant;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "good_order")
public class GoodOrder {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String id;

    @Builder.Default
    @Column(name = "state_value", nullable = false)
    private OrderState state = OrderState.AWAIT_PAYMENT;

    @Builder.Default
    @Column(name = "create_date", nullable = false)
    @Temporal(TemporalType.DATE)
    private Date createDate = Date.from(Instant.now());

    @ManyToOne
    @JoinColumn(name = "good_id", nullable = false)
    private Good good;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

}
