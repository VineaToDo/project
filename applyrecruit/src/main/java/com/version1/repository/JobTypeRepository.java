package com.version1.repository;

import com.version1.entity.JobType;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface JobTypeRepository extends JpaRepository<JobType,Integer> {

    List<JobType> findByParent(JobType jobType);

}
