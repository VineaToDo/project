package com.version1.repository;

import com.version1.entity.JobIntension;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IntensionRepository extends JpaRepository<JobIntension,Integer> {

}
