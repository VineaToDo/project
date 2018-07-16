package com.version1.service.impl;

import com.version1.VO.QueryPositionVO;
import com.version1.entity.*;
import com.version1.repository.DepartmentRepository;
import com.version1.repository.JobTypeRepository;
import com.version1.repository.PositionRepository;
import com.version1.service.PositionService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Order;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import javax.persistence.criteria.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @ClassName PositionServiceImpl
 * @Description TODO
 * @Date 2018/5/14 11:34
 * @Version 1.0
 */
@Service
@Transactional(readOnly = true)
@Slf4j
public class PositionServiceImpl implements PositionService {

    @Autowired
    private JobTypeRepository jobTypeRepository;

    @Autowired
    private PositionRepository positionRepository;

    @Autowired
    private DepartmentRepository departmentRepository;

    @Override
    public Page<Position> findByQueryPosition(final QueryPositionVO queryPositionVO) {
        Page<Position> positionPage = positionRepository.findAll(new Specification<Position>() {
            @Override
            public Predicate toPredicate(Root<Position> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {

                List<Predicate> predicates = new ArrayList<Predicate>();

                if(null != queryPositionVO.getCompanyId()){
                    predicates.add(criteriaBuilder.equal(root.get("companyInfo").get("id").as(Integer.class),queryPositionVO.getCompanyId()));
                }

                if(null != queryPositionVO.getPositionId()){
                    predicates.add(criteriaBuilder.equal(root.get("id"),queryPositionVO.getPositionId()));
                }

                if(!StringUtils.isEmpty(queryPositionVO.getProperty())){
                    predicates.add(criteriaBuilder.equal(root.get("property").as(String.class),queryPositionVO.getProperty()));
                }

                if(null != queryPositionVO.getTypeId()){
                    predicates.add(criteriaBuilder.equal(root.get("jobType").as(JobType.class),jobTypeRepository.findOne(queryPositionVO.getTypeId())));
                }

                if(null != queryPositionVO.getState()){
                    predicates.add(criteriaBuilder.equal(root.get("state").as(Integer.class),queryPositionVO.getState()));
                }

                if(null != queryPositionVO.getDeptId()){
                    predicates.add(criteriaBuilder.equal(root.get("department").get("id").as(Integer.class),queryPositionVO.getDeptId()));
                }

                if(!StringUtils.isEmpty(queryPositionVO.getPositionKey())){
                    predicates.add(criteriaBuilder.like(root.get("name"),"%"+queryPositionVO.getPositionKey()+"%"));
                }

                if(null != queryPositionVO.getBeginDate()){
                    predicates.add(criteriaBuilder.greaterThanOrEqualTo(root.get("createdTime"),queryPositionVO.getBeginDate()));
                }
                if(null != queryPositionVO.getEndDate()){
                    predicates.add(criteriaBuilder.lessThanOrEqualTo(root.get("deadline"),queryPositionVO.getEndDate()));
                }

                if(queryPositionVO.isCollect()){
                    predicates.add(criteriaBuilder.equal(root.join(root.getModel().getSet("userInfos",UserInfo.class),JoinType.LEFT).get("id").as(Integer.class),queryPositionVO.getUserId()));
                }

                return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
            }
        }, new PageRequest(queryPositionVO.getPageNumber()-1,queryPositionVO.getPageSize(),"desc".equals(queryPositionVO.getSortOrder())?Sort.Direction.DESC:Sort.Direction.ASC,queryPositionVO.getSortName()));

        return positionPage;
    }

    @Override
    public List<Position> findTopPositions() {
        List<Position> positions = null;
        List<Order> orders = new ArrayList<Order>();
        Order orderSent = new Order(Direction.DESC,"sent");
        Order orderCollect = new Order(Direction.DESC,"collect");
        Order orderHit = new Order(Direction.DESC,"hit");
        orders.add(orderSent);
        orders.add(orderCollect);
        orders.add(orderHit);
        try {
            positions = positionRepository.findTop8By(new Sort(orders));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return positions;
    }

    @Override
    @Modifying(clearAutomatically = true)
    @Transactional
    public boolean downAllPast() {
        try {
            positionRepository.updatePastState(new Date());
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    @Override
    @Modifying(clearAutomatically = true)
    @Transactional
    public void increaseHit(int id) {
        try {
            Position position = positionRepository.findOne(id);
            position.setHit(position.getHit() + 1);
            positionRepository.saveAndFlush(position);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    /**
    @Override
    public Page<Position> findByQueryPosition(QueryPositionVO queryPositionVO) {

        Page<Position> positionPage = positionRepository.findAll(new Specification<Position>() {
            @Override
            public Predicate toPredicate(Root<Position> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {

                List<Predicate> predicates = new ArrayList<Predicate>();

                predicates.add(criteriaBuilder.equal(root.get("companyInfo").get("id").as(Integer.class),queryPositionVO.getCompanyId()));

                if(null != queryPositionVO.getState()){
                    predicates.add(criteriaBuilder.equal(root.get("state").as(Integer.class),queryPositionVO.getState()));
                }

                if(null != queryPositionVO.getDeptId()){
                    predicates.add(criteriaBuilder.equal(root.get("department").get("id").as(Integer.class),queryPositionVO.getDeptId()));
                }

                if(null != queryPositionVO.getPositionKey()){
                    predicates.add(criteriaBuilder.like(root.get("name"),"%"+queryPositionVO.getPositionKey()+"%"));
                }

                if(null != queryPositionVO.getBeginDate()){
                    predicates.add(criteriaBuilder.greaterThanOrEqualTo(root.get("createdTime"),queryPositionVO.getBeginDate()));
                }
                if(null != queryPositionVO.getEndDate()){
                    predicates.add(criteriaBuilder.lessThanOrEqualTo(root.get("deadline"),queryPositionVO.getEndDate()));
                }

                return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
            }
        },new PageRequest(queryPositionVO.getPageNumber()-1,queryPositionVO.getPageSize()));

        return positionPage;
    }
    */


    @Override
    @Modifying(clearAutomatically = true)
    @Transactional
    public int updateOrNewPosition(Position position) {

        try {
            if(position.getId() == null){
                position.setJobType(jobTypeRepository.findOne(position.getType()));
                position.setDepartment(departmentRepository.findOne(position.getDeptId()));
                positionRepository.save(position);
                return 0;
            }else {
                Position positionOld = positionRepository.findOne(position.getId());
                positionOld.setName(position.getName());
                positionOld.setSalary(position.getSalary());
                positionOld.setWorkplace(position.getWorkplace());
                positionOld.setProperty(position.getProperty());
                positionOld.setExperience(position.getExperience());
                positionOld.setRecruitNum(position.getRecruitNum());
                positionOld.setDescription(position.getDescription());
                positionOld.setDegree(position.getDegree());
                positionOld.setTag(position.getTag());
                positionOld.setDeadline(position.getDeadline());
                positionOld.setJobType(jobTypeRepository.findOne(position.getType()));
                positionOld.setDepartment(departmentRepository.findOne(position.getDeptId()));
                positionRepository.save(positionOld);
                return 1;
            }
        } catch (Exception e) {
            throw e;
//            e.printStackTrace();
//            return -1;
        }

    }

    @Override
    @Modifying(clearAutomatically = true)
    @Transactional
    public boolean publish(String ids) {

        try {
            String[] idsList = ids.split(",");
            for (String id:idsList){
                int flag = positionRepository.updatePositionState((byte) 1,Integer.parseInt(id));
                log.info("Offline_flag:"+flag);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    @Override
    @Modifying(clearAutomatically = true)
    @Transactional
    public boolean offline(String ids) {
        try {
            String[] idsList = ids.split(",");
            for (String id:idsList){
                int flag = positionRepository.updatePositionState((byte) 2,Integer.parseInt(id));
                log.info("Offline_flag:"+flag);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }

    @Override
    @Modifying(clearAutomatically = true)
    @Transactional
    public boolean delete(String ids) {
        try {
            String[] idsList = ids.split(",");
            for (String id:idsList){
                positionRepository.deleteById(Integer.parseInt(id));
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }

    @Override
    @Modifying(clearAutomatically = true)
    @Transactional
    public int lock(int id) {
        int locked;
        try {
            Position position = positionRepository.findOne(id);
            locked = position.getIsLocked()?1:0;
            position.setIsLocked(!position.getIsLocked());
            positionRepository.save(position);
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }

        return locked;
    }


}
