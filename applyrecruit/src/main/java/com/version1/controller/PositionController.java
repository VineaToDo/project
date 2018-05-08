package com.version1.controller;

import com.version1.VO.QueryParamVO;
import com.version1.VO.TableResponseVO;
import com.version1.entity.Position;
import com.version1.entity.UserInfo;
import com.version1.repository.DepartmentRepository;
import com.version1.repository.PositionRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

/**
 * @ClassName PositionController
 * @Description TODO
 * @Date 2018/5/5 22:33
 * @Version 1.0
 */
@Controller
@RequestMapping("/position")
@Slf4j
public class PositionController extends BaseController {

    @Autowired
    private DepartmentRepository departmentRepository;

    @Autowired
    private PositionRepository positionRepository;


    @GetMapping("/position_review/{property}")
    public String goPositionList(@PathVariable String property){

        getModelMap().addAttribute("property",property);

        return "positions_review";
    }

    @GetMapping("/getPosition")
    public String getPosition(){

        return "/enterprise/positions_manage";
    }


    @ResponseBody
    @RequestMapping("/positionList")
    public TableResponseVO positionList(QueryParamVO queryParamVO){
        TableResponseVO tableResponseVO = new TableResponseVO();
        Page<Position> page =  positionRepository.findByProperty(queryParamVO.getProperty(),new PageRequest(queryParamVO.getPageNumber()-1,queryParamVO.getPageSize()));
        tableResponseVO.setTotal((int)page.getTotalElements());
        tableResponseVO.setRows(page.getContent());
        return tableResponseVO;
    }


    @ResponseBody
    @RequestMapping("/positionManage")
    public TableResponseVO positionAllList(QueryParamVO queryParamVO){
        TableResponseVO tableResponseVO = new TableResponseVO();
        UserInfo userInfo = (UserInfo)getRequest().getSession().getAttribute("user");
        Page<Position> page = positionRepository.findByCompanyInfoId(userInfo.getCompanyInfo().getId(),new PageRequest(queryParamVO.getPageNumber()-1,queryParamVO.getPageSize()));
        tableResponseVO.setTotal((int)page.getTotalElements());
        tableResponseVO.setRows(page.getContent());
        return tableResponseVO;
    }



    @PostMapping("/updatePostion")
    public String updatePosition(@Valid Position position, BindingResult bindingResult){
        if(bindingResult.hasErrors()){
            log.info(bindingResult.getFieldError().getDefaultMessage());
            return "error";
        }
        if (position.getId() == null){
            UserInfo userInfo = (UserInfo)getRequest().getSession().getAttribute("user");
            position.setCompanyInfo(userInfo.getCompanyInfo());
            position.setDepartment(departmentRepository.findOne(position.getDeptId()));
        }
        positionRepository.save(position);

        return "/enterprise/index";
    }

    @GetMapping("/editPosition")
    public String editPrepare(@RequestParam(required = false) Integer id){
        if(id != null){
            Position position = positionRepository.findOne(id);
            getModelMap().addAttribute("position",position);
        }

        UserInfo userInfo = (UserInfo)getRequest().getSession().getAttribute("user");
        getModelMap().addAttribute("deptList",userInfo.getCompanyInfo().getDepartments());

        return "/enterprise/job_publish";
    }

}
