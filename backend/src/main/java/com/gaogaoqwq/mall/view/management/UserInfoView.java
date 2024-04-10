package com.gaogaoqwq.mall.view.management;

import com.gaogaoqwq.mall.entity.User;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor
public class UserInfoView {

    private Long id;

    private String username;

    private Integer gender;

    private String rolename;

    private boolean enable;

    public static UserInfoView fromUser(User user) {
        return UserInfoView.builder()
            .id(user.getId())
            .username(user.getUsername())
            .gender(user.getGender().ordinal())
            .rolename(user.getRole().getName())
            .enable(user.getEnable())
            .build();
    }

}
