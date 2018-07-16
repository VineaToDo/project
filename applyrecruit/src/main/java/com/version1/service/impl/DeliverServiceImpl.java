package com.version1.service.impl;

import com.version1.VO.MessageVO;
import com.version1.VO.QueryDeliverVO;
import com.version1.entity.CompanyInfo;
import com.version1.entity.Deliver;
import com.version1.entity.ResumeInfo;
import com.version1.repository.DeliverRepository;
import com.version1.service.DeliverService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.criteria.*;
import java.util.ArrayList;
import java.util.List;

/**
 * @ClassName DeliverServiceImpl
 * @Description TODO
 * @Date 2018/5/16 15:14
 * @Version 1.0
 */
@Service
@Transactional(readOnly = true)
@Slf4j
public class DeliverServiceImpl implements DeliverService {

    @Autowired
    private DeliverRepository deliverRepository;


    @Override
    public Deliver getDeliverById(Integer id) {
        Deliver deliver = null;
        try {
            deliver = deliverRepository.findOne(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return deliver;
    }

    @Override
    @Modifying(clearAutomatically = true)
    @Transactional
    public boolean inform(Deliver d) {
        try {
            Deliver deliver = deliverRepository.findOne(d.getId());
            deliver.setInformed(true);
            deliver.setReason(d.getReason());
            deliver.setContactName(d.getContactName());
            deliver.setContactPhone(d.getContactPhone());
            deliverRepository.saveAndFlush(deliver);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    @Override
    public boolean updateKnown(Integer id) {
        return true;
    }

    @Override
    public List<MessageVO> getMessageTip(ResumeInfo resumeInfo) {
        List<MessageVO> messageVOList = null;
        try {
            messageVOList = deliverRepository.findDynamicState(resumeInfo);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return messageVOList;
    }

    @Override
    public List<Deliver> findNewestDeliver(CompanyInfo companyInfo) {

        List<Deliver> delivers = null;
        try {
            delivers = deliverRepository.findTop5ByPositionCompanyInfoOrderByCreatedTimeDesc(companyInfo);
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            return delivers;
        }
    }

    @Override
    @Transactional
    @Modifying(clearAutomatically = true)
    public boolean collectDeliver(Integer id) {
        try {
            Deliver deliver = deliverRepository.findOne(id);
            deliver.setIsCollected(!deliver.getIsCollected());
            deliverRepository.save(deliver);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    @Override
    @Transactional
    @Modifying(clearAutomatically = true)
    public boolean feedback(Deliver deliver) {
        try {
            Deliver deliverOld = deliverRepository.findOne(deliver.getId());
            if(deliver.getAvailable() == 2){
                deliverOld.setInterviewTime(deliver.getInterviewTime());
                deliverOld.setInterviewAddr(deliver.getInterviewAddr());
                deliverOld.setContactName(deliver.getContactName());
                deliverOld.setContactPhone(deliver.getContactPhone());
            }
            if(deliver.getReason() != null)
                deliverOld.setReason(deliver.getReason());
            deliverOld.setAvailable(deliver.getAvailable());
            deliverRepository.saveAndFlush(deliverOld);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    @Override
    @Modifying(clearAutomatically = true)
    @Transactional
    public Page<Deliver> findDeliverList(QueryDeliverVO queryDeliverVO) {
        Page<Deliver> deliverPage = deliverRepository.findAll(new Specification<Deliver>() {
            @Override
            public Predicate toPredicate(Root<Deliver> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<Predicate>();

                if(null != queryDeliverVO.getCompanyId()) predicates.add(criteriaBuilder.equal(root.get("position").get("companyInfo").get("id"),queryDeliverVO.getCompanyId()));

                if(null != queryDeliverVO.getResumeId()) {
                    deliverRepository.updateKnown(queryDeliverVO.getResumeId());
                    predicates.add(criteriaBuilder.equal(root.get("resumeInfo").get("id"),queryDeliverVO.getResumeId()));
                }

                if(null != queryDeliverVO.getSelectedDate()) predicates.add(criteriaBuilder.greaterThanOrEqualTo(root.get("createdTime"), queryDeliverVO.getSelectedDate()));

                if(null != queryDeliverVO.getPositionId()) predicates.add(criteriaBuilder.equal(root.get("position").get("id"), queryDeliverVO.getPositionId()));

                if(null != queryDeliverVO.getIsCollected()) predicates.add(criteriaBuilder.equal(root.get("isCollected").as(Boolean.class), queryDeliverVO.getIsCollected()));

                if(null != queryDeliverVO.getAvailable()) predicates.add(root.get("available").in(queryDeliverVO.getAvailable()));

                if(null != queryDeliverVO.getInformed()) predicates.add(criteriaBuilder.equal(root.get("informed"), queryDeliverVO.getInformed()));

                return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
            }
        },new PageRequest(queryDeliverVO.getPageNumber()-1, queryDeliverVO.getPageSize(),"desc".equals(queryDeliverVO.getSortOrder())?Sort.Direction.DESC:Sort.Direction.ASC, queryDeliverVO.getSortName()));

        return deliverPage;
    }

}
