package com.gaogaoqwq.mall;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.util.List;
import java.util.Optional;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.jdbc.EmbeddedDatabaseConnection;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;

import com.gaogaoqwq.mall.entity.Role;
import com.gaogaoqwq.mall.entity.User;
import com.gaogaoqwq.mall.repository.RoleRepository;
import com.gaogaoqwq.mall.repository.UserRepository;

@SpringBootTest
@AutoConfigureTestDatabase(connection = EmbeddedDatabaseConnection.H2)
class MallApplicationTests {
    @Autowired
    private UserRepository userRepo;

    @Autowired
    private RoleRepository roleRepo;

    @Test
    void injectedComponentsNotNull() {
        assertNotNull(userRepo);
        assertNotNull(roleRepo);
    }

    @Test
    void disableAndDeleteTest() {
        List<Role> roles = roleRepo.findAll();
        assertNotEquals(
            Optional.empty(), roleRepo.findByName(roles.get(0).getName()),
            "Failed to default roles exist");

        String testUsername = "test_user";
        String testPassword = "test_password";
        User user = User.builder()
                .username(testUsername)
                .password(testPassword)
                .role(roleRepo.findByName(roles.get(1).getName()).get())
                .build();
        userRepo.save(user);
        assertNotEquals(
                Optional.empty(), userRepo.findUserByUsername(testUsername),
                "Failed to test user successfully insert");

        user = userRepo.findUserByUsername(testUsername).get();
        userRepo.toggleUserEnableById(false, user.getId());
        assertEquals(
                false, userRepo.findUserByUsername(testUsername).get().getEnable(),
                "Failed to test user successfully disable");

        userRepo.deleteDisabledUser();
        assertEquals(
                Optional.empty(), userRepo.findUserByUsername(testUsername),
                "Failed to disabled test user delete");
    }

}
