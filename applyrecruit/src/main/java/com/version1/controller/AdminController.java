package com.version1.controller;

import com.alibaba.fastjson.JSON;
import com.version1.VO.QueryParamVO;
import com.version1.VO.ResultVO;
import com.version1.VO.TableResponseVO;
import com.version1.entity.JobType;
import com.version1.entity.Position;
import com.version1.entity.UserInfo;
import com.version1.repository.JobTypeRepository;
import com.version1.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;
import java.util.Map;

/**
 * @ClassName AdminController
 * @Description TODO
 * @Date 2018/5/10 15:40
 * @Version 1.0
 */
@Controller
@RequestMapping("/admin")
public class AdminController extends BaseController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private JobTypeRepository jobTypeRepository;


    @GetMapping("/relayUrl/{url}")
    public String relayUrl(@PathVariable String url){

        return "/admin/" + url;
    }

    @ResponseBody
    @RequestMapping("/personalList")
    public TableResponseVO personalList(QueryParamVO queryParamVO){

        TableResponseVO tableResponseVO = new TableResponseVO();

        Page<UserInfo> page = userRepository.findByRoleId(1,new PageRequest(queryParamVO.getPageNumber()-1,queryParamVO.getPageSize()));

        tableResponseVO.setTotal((int)page.getTotalElements());
        tableResponseVO.setRows(page.getContent());
        return tableResponseVO;
    }
    @ResponseBody
    @RequestMapping("/enterpriseList")
    public TableResponseVO enterpriseList(QueryParamVO queryParamVO){

        TableResponseVO tableResponseVO = new TableResponseVO();

        Page<UserInfo> page = userRepository.findByRoleId(2,new PageRequest(queryParamVO.getPageNumber()-1,queryParamVO.getPageSize()));

        tableResponseVO.setTotal((int)page.getTotalElements());
        tableResponseVO.setRows(page.getContent());
        return tableResponseVO;
    }
    @ResponseBody
    @RequestMapping("/positionTypeList")
    public List<JobType> positionTypeList(){

        TableResponseVO tableResponseVO = new TableResponseVO();

        List<JobType> jobTypes = jobTypeRepository.findAll();

        for (int i = 0;i < jobTypes.size();i++){
            JobType jobType = jobTypes.get(i);
            if(jobType.getParent() == null) jobType.setPid(0);
            else jobType.setPid(jobType.getParent().getId());
        }

//        tableResponseVO.setTotal(jobTypes.size());
//        tableResponseVO.setRows(jobTypes);
        return jobTypes;
    }
    @ResponseBody
    @PostMapping("/saveJobType")
    public ResultVO saveJobType(JobType jobType){
        JobType jobTypeOld;
        ResultVO resultVO = new ResultVO();
        try {
            if(jobType.getId() != null){
                jobTypeOld = jobTypeRepository.findOne(jobType.getId());
                jobTypeOld.setName(jobType.getName());
                jobTypeRepository.save(jobTypeOld);
                resultVO.setCode(2);
                resultVO.setMsg("修改成功");
            }else {
                if(jobType.getPid() != null){
                    jobType.setParent(jobTypeRepository.findOne(jobType.getPid()));
                    jobTypeRepository.save(jobType);
                    resultVO.setCode(1);
                    resultVO.setMsg("新增二级类型成功");
                }else {
                    jobTypeRepository.save(jobType);
                    resultVO.setCode(1);
                    resultVO.setMsg("新增一级类型成功");
                }
            }
        } catch (Exception e) {
            resultVO.setCode(0);
            resultVO.setMsg("保存失败");
            e.printStackTrace();
            return resultVO;
        }
        return resultVO;
    }

    @ResponseBody
    @RequestMapping("/deleteJobType")
    public ResultVO deleteJobType(@RequestParam String ids){

        String[] idList = ids.split(",");

        ResultVO resultVO = new ResultVO();
        try {
            for (String id:idList){
                jobTypeRepository.delete(Integer.valueOf(id));
            }
        } catch (Exception e) {
            resultVO.setCode(0);
            resultVO.setMsg("删除失败");
            e.printStackTrace();
            return resultVO;
        }
        resultVO.setCode(1);
        resultVO.setMsg("删除成功");
        return resultVO;
    }




}
