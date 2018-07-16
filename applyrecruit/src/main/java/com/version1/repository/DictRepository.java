package com.version1.repository;

import com.version1.entity.Dict;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DictRepository extends JpaRepository<Dict,Integer> {

    Dict findByCode(String code);

}
