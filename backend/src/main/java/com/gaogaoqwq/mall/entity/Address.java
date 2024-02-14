package com.gaogaoqwq.mall.entity;

import java.util.Collection;

import com.gaogaoqwq.mall.dto.AddressDto;

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
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String uuid;

    @Column(name = "recipient")
    private String recipient;

    @Column(name = "phone_number")
    private String phoneNumber;

    @Column(name = "province")
    private String province;

    @Column(name = "detail")
    private String detail;

    @ManyToMany
    @JoinTable(name = "user_address")
    private Collection<User> users;

    public static Address fromAddressDto(AddressDto addressDto) {
        return Address.builder()
        .recipient(addressDto.getRecipient())
        .build();
    }

}
