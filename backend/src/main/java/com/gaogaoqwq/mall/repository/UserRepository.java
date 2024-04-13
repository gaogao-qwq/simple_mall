package com.gaogaoqwq.mall.repository;

import com.gaogaoqwq.mall.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Transactional(readOnly = true)
public interface UserRepository extends JpaRepository<User, Long> {

    boolean existsByUsername(String username);

    Optional<User> findUserByUsername(String username);

    List<User> findByCreateDateAfter(Date date);

    List<User> findByCreateDateBefore(Date date);

    List<User> findByCreateDateBetween(Date startDate, Date endDate);

    @Modifying
    @Transactional
    @Query("update User u set u.enable = ?1 where u.id = ?2")
    void toggleUserEnableById(Boolean enable, Long id);

    @Modifying
    @Query("delete from User u where u.enable = false")
    void deleteDisabledUser();

}
