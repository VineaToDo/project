package com.version1.controller;

import com.version1.VO.QueryPositionVO;
import com.version1.VO.ResultVO;
import com.version1.VO.TableResponseVO;
import com.version1.entity.*;
import com.version1.repository.DepartmentRepository;
import com.version1.service.CompanyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

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
    private CompanyService companyService;

    @GetMapping("/editCompanyInfo")
    public String eidtPrepare(){
        UserInfo userInfo = getLoginUser();
        if(userInfo.getCompanyInfo() != null) {
            getModelMap().addAttribute("company", userInfo.getCompanyInfo());
        }
        return "/enterprise/companyInfo_edit";
    }

    @PostMapping("/saveCompany")
    public String saveCompanyInfo(@Valid CompanyInfo companyInfo){

        companyService.updateOrNewCompany(companyInfo,getLoginUser());

        return "/enterprise/index";
    }


    @GetMapping("/deptPage")
    public String deptPage(){
        return "/enterprise/departments_edit";
    }

    @ResponseBody
    @RequestMapping("/deptList")
    public TableResponseVO deptList(QueryPositionVO queryPositionVO){
        TableResponseVO tableResponseVO = new TableResponseVO();
        queryPositionVO.setCompanyId(getLoginUser().getCompanyInfo().getId());
        Page<Department> page = companyService.findDeptList(queryPositionVO);
        tableResponseVO.setTotal((int)page.getTotalElements());
        tableResponseVO.setRows(page.getContent());
        return tableResponseVO;
    }

    @ResponseBody
    @PostMapping("/saveDepartments")
    public ResultVO saveDepartments(Department department){
        int res;
        ResultVO resultVO = new ResultVO();
        department.setCompanyInfo(getLoginUser().getCompanyInfo());
        try {
            res = companyService.saveDept(department,getLoginUser());
        } catch (Exception e) {
            resultVO.setCode(-1);
            resultVO.setMsg("操作失败");
            e.printStackTrace();
            return resultVO;
        }
        if (res == 0){
            resultVO.setCode(0);
            resultVO.setMsg("新增成功");
        }else {
            resultVO.setCode(1);
            resultVO.setMsg("修改成功");
        }
        return resultVO;
    }

    @ResponseBody
    @RequestMapping("/delDept")
    public ResultVO delDept(String ids){
        if (companyService.deleteDept(ids,getLoginUser())){
            return new ResultVO(1,"删除成功");
        }else {
            return new ResultVO(0,"删除失败");
        }
    }

}
