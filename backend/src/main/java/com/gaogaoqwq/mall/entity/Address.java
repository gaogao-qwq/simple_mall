package com.gaogaoqwq.mall.entity;

import com.gaogaoqwq.mall.dto.AddressDto;
import com.gaogaoqwq.mall.enums.Province;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "address")
public class Address {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String id;

    @Column(name = "recipient")
    private String recipient;

    @Column(name = "phone_number")
    private String phoneNumber;

    @Column(name = "province")
    private Province province;

    @Column(name = "detail")
    private String detail;

    @OneToOne(mappedBy = "defaultAddress", cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true)
    private User defaultUser;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user", nullable = false)
    private User user;

    public static Address fromAddressDto(AddressDto addressDto) {
        return Address.builder()
                .recipient(addressDto.getRecipient())
                .phoneNumber(addressDto.getPhoneNumber())
                .province(Province.fromCode(addressDto.getProvinceCode()))
                .detail(addressDto.getDetail())
                .build();
    }

}
