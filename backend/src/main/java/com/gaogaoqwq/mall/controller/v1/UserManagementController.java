package com.gaogaoqwq.mall.controller.v1;

import java.util.Optional;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gaogaoqwq.mall.response.R;
import com.gaogaoqwq.mall.service.UserService;
import com.gaogaoqwq.mall.view.CountView;
import com.gaogaoqwq.mall.view.management.UserInfoView;

import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RestController
@RequestMapping(path = "/v1/user-management", produces = "application/json")
@ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Successful operation"),
        @ApiResponse(responseCode = "401", description = "Authentication failed")
})
public class UserManagementController {

    private final UserService userService;

    @GetMapping("/count")
    public R getUserCount() {
        CountView view = new CountView(userService.getUserCount());
        return R.successBuilder().data(view).build();
    }

    @GetMapping("/list")
    public R getUserList(@RequestParam int page,
            @RequestParam(required = false) Optional<Integer> size) {
        if (size.isEmpty())
            size = Optional.of(10);
        var users = userService.getUserListByPage(page, size.get());
        var views = users.stream()
                .map(UserInfoView::fromUser).toList();
        return R.successBuilder().data(views).build();
    }

}
