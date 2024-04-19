package com.gaogaoqwq.mall.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.List;

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

    @Column(name = "description", nullable = false, length = 1024)
    private String description;

    @Column(name = "price", precision = 12, scale = 2, nullable = false)
    private BigDecimal price;

    @Column(name = "stock", nullable = false)
    private Integer stock;

    @Column(name = "preview_img_url", nullable = false)
    private String previewImgUrl;

    @OneToOne(mappedBy = "good")
    private GoodSwiper goodSwiper;

    @ManyToOne
    @JoinColumn(name = "sub_category_id", nullable = false)
    private GoodSubCategory subCategory;

    @OneToMany(mappedBy = "good", cascade = CascadeType.ALL)
    private List<GoodImage> images;

    @OneToMany(mappedBy = "good", cascade = CascadeType.ALL)
    private List<GoodOrder> goodOrders;

    @OneToMany(mappedBy = "good", cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true)
    private List<CartItem> cartItems;

}
