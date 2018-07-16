package com.version1.service;

import com.version1.VO.QueryPositionVO;
import com.version1.entity.CompanyInfo;
import com.version1.entity.Department;
import com.version1.entity.UserInfo;
import org.springframework.data.domain.Page;

/**
 * @ClassName CompanyServiceImpl
 * @Description TODO
 * @Date 2018/5/23 20:22
 * @Version 1.0
 */
public interface CompanyService {

    int updateOrNewCompany(CompanyInfo companyInfo, UserInfo userInfo);

    int saveDept(Department department,UserInfo userInfo);

    int checkAvaiable(Integer id);

    boolean deleteDept(String ids,UserInfo userInfo);

    Page<Department> findDeptList(QueryPositionVO queryPositionVO);

}
