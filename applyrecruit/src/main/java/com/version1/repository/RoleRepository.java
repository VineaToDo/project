package com.version1.repository;

import com.version1.entity.SysRole;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoleRepository extends JpaRepository<SysRole,Integer> {

}
