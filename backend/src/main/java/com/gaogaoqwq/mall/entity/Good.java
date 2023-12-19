package com.gaogaoqwq.mall.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Collection;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "good")
public class Good {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "introduction", nullable = false, length = 1024)
    private String introduction;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "good")
    private Collection<GoodImage> images;

    @ManyToMany(mappedBy = "goods")
    private Collection<GoodSubCategory> subCategories;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "good")
    private Collection<GoodOrder> goodOrders;

}
