package com.version1.repository;

import com.version1.entity.CompanyInfo;
import com.version1.entity.Position;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PositionRepository extends JpaRepository<Position,Integer> {


    Page<Position> findByProperty(String property, Pageable pageable);


    Page<Position> findByCompanyInfoId(int companyId, Pageable pageable);

}
