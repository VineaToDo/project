package com.version1.repository;

import com.version1.entity.Position;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.Date;
import java.util.List;

public interface PositionRepository extends JpaRepository<Position,Integer>,JpaSpecificationExecutor<Position> {


//    Page<Position> findByProperty(String property, Pageable pageable);

    List<Position> findTop8By(Sort sort);
//    Page<Position> findByCompanyInfoId(int companyId, Pageable pageable);

    @Modifying(clearAutomatically = true)
    @Query("update Position p set p.state = ?1 where p.id = ?2")
    int updatePositionState(byte state, Integer id);

    @Modifying(clearAutomatically = true)
    @Query("delete from Position p where p.id = ?1")
    void deleteById(Integer id);

    @Modifying(clearAutomatically = true)
    @Query("update Position p set p.state = 2 where p.state = 1 and p.deadline < ?1")
    int updatePastState(Date now);

}
