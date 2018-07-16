package com.version1.service.impl;

import com.version1.VO.QueryPositionVO;
import com.version1.entity.CompanyInfo;
import com.version1.entity.Department;
import com.version1.entity.UserInfo;
import com.version1.repository.CompanyRepository;
import com.version1.repository.DepartmentRepository;
import com.version1.repository.UserRepository;
import com.version1.service.CompanyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


/**
 * @ClassName CompanyServiceImpl
 * @Description TODO
 * @Date 2018/5/23 20:23
 * @Version 1.0
 */
@Service
@Transactional(readOnly = true)
public class CompanyServiceImpl implements CompanyService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CompanyRepository companyRepository;

    @Autowired
    private DepartmentRepository departmentRepository;

    @Override
    @Modifying(clearAutomatically = true)
    @Transactional
    public int updateOrNewCompany(CompanyInfo companyInfo, UserInfo userInfo) {

        if(companyInfo.getId() == null){
            CompanyInfo companyInfoNew = companyRepository.save(companyInfo);
            userInfo.setCompanyInfo(companyInfoNew);
            userRepository.save(userInfo);
            return 1;
        }else {
            CompanyInfo companyInfoOld = companyRepository.findOne(companyInfo.getId());
            companyInfoOld.setName(companyInfo.getName());
            companyInfoOld.setTrade(companyInfo.getTrade());
            companyInfoOld.setAddress(companyInfo.getAddress());
            companyInfoOld.setIntroduction(companyInfo.getIntroduction());
            companyInfoOld.setPropertyCode(companyInfo.getPropertyCode());
            companyInfoOld.setDimensionsCode(companyInfo.getDimensionsCode());
            userInfo.setCompanyInfo(companyRepository.save(companyInfoOld));
        }

        return 2;
    }

    @Override
    @Modifying(clearAutomatically = true)
    @Transactional
    public int saveDept(Department department,UserInfo userInfo){
        try {
            if(department.getId() == null){
                departmentRepository.save(department);
                return 0;
            }else {
                Department departmentOld = departmentRepository.findOne(department.getId());
                departmentOld.setName(department.getName());
                departmentRepository.saveAndFlush(departmentOld);
                return 1;
            }
        } catch (Exception e) {
            throw e;
        } finally {
            userInfo.getCompanyInfo().setDepartments(departmentRepository.findByCompanyInfo(userInfo.getCompanyInfo()));
        }
    }

    @Override
    @Modifying(clearAutomatically = true)
    @Transactional
    public int checkAvaiable(Integer id) {
        int available = 0;
        try {
            CompanyInfo companyInfo = companyRepository.findOne(id);
            available = companyInfo.getAvailable()?1:0;
            companyInfo.setAvailable(!companyInfo.getAvailable());
            companyRepository.save(companyInfo);
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }

        return available;
    }

    @Override
    @Modifying(clearAutomatically = true)
    @Transactional
    public boolean deleteDept(String ids,UserInfo userInfo) {
        String[] idList = ids.split(",");
        try {
            for (String id:idList){
                departmentRepository.delete(Integer.valueOf(id));
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            userInfo.getCompanyInfo().setDepartments(departmentRepository.findByCompanyInfo(userInfo.getCompanyInfo()));
        }
        return true;
    }

    @Override
    public Page<Department> findDeptList(QueryPositionVO queryPositionVO) {
        Page<Department> page = departmentRepository.findAllDepartmentsByCompanyId(queryPositionVO.getCompanyId(),
                new PageRequest(queryPositionVO.getPageNumber()-1,queryPositionVO.getPageSize(),
                        "desc".equals(queryPositionVO.getSortOrder())?Sort.Direction.DESC:Sort.Direction.ASC,queryPositionVO.getSortName()));
        return page;
    }
}
