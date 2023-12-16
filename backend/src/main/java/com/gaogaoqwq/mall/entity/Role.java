package com.gaogaoqwq.mall.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.Collection;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "role")
public class Role {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "description")
    private String description;

    @Column(name = "editable", nullable = false)
    private Boolean editable;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "role")
    Collection<User> users;

}
