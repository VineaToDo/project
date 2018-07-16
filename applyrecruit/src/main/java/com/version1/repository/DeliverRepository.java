package com.version1.repository;

import com.version1.VO.MessageVO;
import com.version1.entity.CompanyInfo;
import com.version1.entity.Deliver;
import com.version1.entity.Position;
import com.version1.entity.ResumeInfo;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * @ClassName DeliverRepository
 * @Description TODO
 * @Date 2018/5/15 21:34
 * @Version 1.0
 */
public interface DeliverRepository extends JpaRepository<Deliver,Integer>,JpaSpecificationExecutor<Deliver> {

    Deliver findByResumeInfoAndPosition(ResumeInfo resumeInfo, Position position);

    Page<Deliver> findByResumeInfo(ResumeInfo resumeInfo, Pageable pageable);

    @Modifying
    @Query("update Deliver d set d.known = true where d.resumeInfo.id = ?1 and d.known = false")
    int updateKnown(Integer resumeId);

    long countByKnownFalseAndResumeInfo(ResumeInfo resumeInfo);

    @Query("select new com.version1.VO.MessageVO(d.available,d.position.name) from Deliver d where d.known=false and d.resumeInfo = ?1")
    List<MessageVO> findDynamicState(ResumeInfo resumeInfo);

    List<Deliver> findTop5ByPositionCompanyInfoOrderByCreatedTimeDesc(CompanyInfo companyInfo);


}
