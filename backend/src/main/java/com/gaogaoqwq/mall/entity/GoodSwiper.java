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
@Table(name = "good_swiper")
public class GoodSwiper {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String id;

    @Column(name = "swiper_img_url", nullable = false)
    private String swiperImgUrl;

    @OneToOne
    @JoinColumn(name = "good_id", nullable = false)
    private Good good;

}
