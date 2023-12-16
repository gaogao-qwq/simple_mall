package com.gaogaoqwq.mall;

import com.gaogaoqwq.mall.entity.Role;
import com.gaogaoqwq.mall.enums.RoleName;
import com.gaogaoqwq.mall.repository.RoleRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.List;

@Slf4j
@Component
@RequiredArgsConstructor
public class DataInitializer implements CommandLineRunner {

    private final RoleRepository roleRepo;

    @Override
    public void run(String... args) {
        if (roleRepo.existsById(1L)) return;

        var roles = List.of(
                Role.builder().name(RoleName.ADMIN).description("管理员").editable(false).build(),
                Role.builder().name(RoleName.CUSTOMER).description("普通用户").editable(false).build()
        );

        roleRepo.saveAll(roles);
    }
}
