package com.version1.repository;

import com.version1.entity.CompanyInfo;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CompanyRepository extends JpaRepository<CompanyInfo,Integer> {

}
