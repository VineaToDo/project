package com.version1.repository;

import com.version1.entity.UserInfo;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<UserInfo,Integer> {

    UserInfo findByUserName(String username);

    Page<UserInfo> findByRoleId(int roleId, Pageable pageable);

}
