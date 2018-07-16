package com.version1.repository;

import com.version1.entity.PersonalInfo;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * @ClassName PersonalRepository
 * @Description TODO
 * @Date 2018/5/31 1:15
 * @Version 1.0
 */
public interface PersonalRepository extends JpaRepository<PersonalInfo,Integer> {

}
