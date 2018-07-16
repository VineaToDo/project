package com.version1.service;

import com.version1.VO.MessageVO;
import com.version1.VO.QueryDeliverVO;
import com.version1.entity.CompanyInfo;
import com.version1.entity.Deliver;
import com.version1.entity.ResumeInfo;
import org.springframework.data.domain.Page;

import java.util.List;

public interface DeliverService {
//    Page<Deliver> findByQueryParam(QueryParamVO queryParamVO);

    Page<Deliver> findDeliverList(QueryDeliverVO queryDeliverVO);

    Deliver getDeliverById(Integer id);

    boolean inform(Deliver deliver);

    boolean updateKnown(Integer id);

    boolean collectDeliver(Integer id);

    boolean feedback(Deliver deliver);

    List<MessageVO> getMessageTip(ResumeInfo resumeInfo);

    List<Deliver> findNewestDeliver(CompanyInfo companyInfo);

}
