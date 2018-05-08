package com.version1.repository;

import com.version1.entity.CompanyInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface CompanyRepository extends JpaRepository<CompanyInfo,Integer> {

}
