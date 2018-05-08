package com.version1.controller;

import com.version1.VO.QueryParamVO;
import com.version1.VO.ResultVO;
import com.version1.VO.TableResponseVO;
import com.version1.entity.CompanyInfo;
import com.version1.entity.Department;
import com.version1.entity.UserInfo;
import com.version1.repository.CompanyRepository;
import com.version1.repository.DepartmentRepository;
import com.version1.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

/**
 * @ClassName CompanyController
 * @Description TODO
 * @Date 2018/5/7 13:25
 * @Version 1.0
 */
@Controller
@RequestMapping("/company")
public class CompanyController extends BaseController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private DepartmentRepository departmentRepository;
    @Autowired
    private CompanyRepository companyRepository;

    @GetMapping("/editCompanyInfo")
    public String eidtPrepare(){

        UserInfo userInfo = (UserInfo) getRequest().getSession().getAttribute("user");
        if(userInfo.getCompanyInfo() != null)
            getModelMap().addAttribute("company",userInfo.getCompanyInfo());

        return "/enterprise/companyInfo_edit";
    }

    @PostMapping("/saveCompany")
    public String saveCompanyInfo(@Valid CompanyInfo companyInfo){

        CompanyInfo companyInfoNew = companyRepository.save(companyInfo);
        UserInfo userInfo = (UserInfo) getRequest().getSession().getAttribute("user");
        userInfo.setCompanyInfo(companyInfoNew);
        userRepository.save(userInfo);
        return "/enterprise/index";
    }


    @GetMapping("/deptPage")
    public String deptPage(){
        return "/enterprise/departments_edit";
    }

    @ResponseBody
    @RequestMapping("/deptList")
    public TableResponseVO deptList(QueryParamVO queryParamVO){
        TableResponseVO tableResponseVO = new TableResponseVO();

        int id =  ((UserInfo)getRequest().getSession().getAttribute("user")).getCompanyInfo().getId();
        Page<Department> page = departmentRepository.findAllDepartmentsByCompanyId(id,new PageRequest(queryParamVO.getPageNumber()-1,queryParamVO.getPageSize()));

        tableResponseVO.setTotal((int)page.getTotalElements());
        tableResponseVO.setRows(page.getContent());

        return tableResponseVO;
    }

    @ResponseBody
    @PostMapping("/saveDepartments")
    public ResultVO saveDepartments(@RequestParam String deptName){
        ResultVO resultVO = new ResultVO();
        Department department = new Department();
        department.setName(deptName);
        try {
            department.setCompanyInfo(((UserInfo)getRequest().getSession().getAttribute("user")).getCompanyInfo());
            departmentRepository.save(department);
        } catch (Exception e) {
            resultVO.setCode(0);
            resultVO.setMsg("保存失败");
            e.printStackTrace();
            return resultVO;
        }
        resultVO.setCode(1);
        resultVO.setMsg("保存成功");

        return resultVO;
    }


}
