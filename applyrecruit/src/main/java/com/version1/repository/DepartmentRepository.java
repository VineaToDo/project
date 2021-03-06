package com.version1.repository;

import com.version1.entity.CompanyInfo;
import com.version1.entity.Department;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface DepartmentRepository extends JpaRepository<Department,Integer> {

    @Query("select dept from Department dept where dept.companyInfo.id = ?1")
    Page<Department> findAllDepartmentsByCompanyId(int companyId, Pageable pageable);

    List<Department> findByCompanyInfo(CompanyInfo companyInfo);

}
