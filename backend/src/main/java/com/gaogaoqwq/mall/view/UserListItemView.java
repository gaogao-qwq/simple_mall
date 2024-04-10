package com.gaogaoqwq.mall.view;

import com.gaogaoqwq.mall.entity.Role;
import com.gaogaoqwq.mall.entity.User;
import com.gaogaoqwq.mall.enums.Gender;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor
public class UserListItemView {

    private Long id;

    private String name;

    private Gender gender;

    private Boolean enable;
    
    private Role role;

    public static UserListItemView fromUser(User user) {
        return UserListItemView.builder()
                .id(user.getId())
                .name(user.getUsername())
                .gender(user.getGender())
                .enable(user.getEnable())
                .role(user.getRole())
                .build();
    }

}
