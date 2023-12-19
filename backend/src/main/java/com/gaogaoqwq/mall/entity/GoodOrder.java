package com.gaogaoqwq.mall.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "good_order")
public class GoodOrder {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String uuid;

    @Column(name = "state_value")
    private int state;

    @ManyToOne
    @JoinColumn(name = "good_id", nullable = false)
    private Good good;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

}
