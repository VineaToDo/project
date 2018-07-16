package com.version1.service.impl;

import com.version1.VO.QueryComplaint;
import com.version1.entity.Complaint;
import com.version1.entity.Position;
import com.version1.entity.UserInfo;
import com.version1.repository.ComplaintRepository;
import com.version1.repository.PositionRepository;
import com.version1.service.ComplaintService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.List;

/**
 * @ClassName ComplaintServiceImpl
 * @Description TODO
 * @Date 2018/5/29 20:34
 * @Version 1.0
 */
@Service
@Transactional(readOnly = true)
public class ComplaintServiceImpl implements ComplaintService {

    @Autowired
    private ComplaintRepository complaintRepository;

    @Autowired
    private PositionRepository positionRepository;

    @Override
    public Page<Complaint> findByQueryComplaint(QueryComplaint queryComplaint) {


        Page<Complaint> complaintPage = complaintRepository.findAll(new Specification<Complaint>() {
            @Override
            public Predicate toPredicate(Root<Complaint> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {

                List<Predicate> predicates = new ArrayList<Predicate>();


                return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
            }
        },new PageRequest(queryComplaint.getPageNumber() - 1,queryComplaint.getPageSize(),"desc".equals(queryComplaint.getSortOrder())?Sort.Direction.DESC:Sort.Direction.ASC,queryComplaint.getSortName()));

        return complaintPage;
    }

    @Override
    @Modifying(clearAutomatically = true)
    @Transactional
    public boolean informPosition(int id, UserInfo userInfo, String reason) {
        Complaint complaint = new Complaint();
        try {
            Position position = positionRepository.findOne(id);

            complaint.setPosition(position);
            complaint.setInformer(userInfo.getUserName());
            complaint.setContactPhone(userInfo.getPhone());
            complaint.setReason(reason);
            complaintRepository.save(complaint);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }
}
