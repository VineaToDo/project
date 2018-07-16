package com.version1.repository;

import com.version1.entity.Complaint;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface ComplaintRepository extends JpaRepository<Complaint,Integer>,JpaSpecificationExecutor<Complaint> {

}
