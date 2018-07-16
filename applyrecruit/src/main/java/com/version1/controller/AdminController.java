package com.version1.controller;

import com.version1.VO.*;
import com.version1.entity.*;
import com.version1.repository.*;
import com.version1.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

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
    private UserService userService;

    @Autowired
    private JobTypeRepository jobTypeRepository;

    @Autowired
    private DictRepository dictRepository;

    @Autowired
    private CompanyService companyService;

    @Autowired
    private PositionService positionService;

    @Autowired
    private DictItemsService dictItemsService;

    @Autowired
    private DeliverService deliverService;

    @Autowired
    private ComplaintService complaintService;

    @GetMapping("/relayUrl/{url}")
    public String relayUrl(@PathVariable String url){

        return "/admin/" + url;
    }

    @ResponseBody
    @RequestMapping("/userList")
    public TableResponseVO personalList(QueryUserVO queryUserVO){
        TableResponseVO tableResponseVO = new TableResponseVO();

        Page<UserInfo> page = userService.findUserList(queryUserVO);

        List<UserInfo> userInfoList = page.getContent();

        if(queryUserVO.getRoleName().equals("recruit") && userInfoList != null){
            for(int i = 0;i < userInfoList.size();i++){
                UserInfo userInfo = userInfoList.get(i);
                userInfo.getCompanyInfo().setProperty(((Map<Integer,DictItems>)getSession().getAttribute("propertyDict")).get(userInfo.getCompanyInfo().getPropertyCode()).getValue());
                userInfo.getCompanyInfo().setDimensions(((Map<Integer,DictItems>)getSession().getAttribute("dimensionsDict")).get(userInfo.getCompanyInfo().getDimensionsCode()).getValue());
            }
        }

        tableResponseVO.setTotal((int)page.getTotalElements());
        tableResponseVO.setRows(userInfoList);
        return tableResponseVO;
    }

    @ResponseBody
    @RequestMapping("/lockUser")
    public ResultVO lockUser(Integer userId){
        ResultVO resultVO = new ResultVO();
        int res = userService.lockUser(userId);
        if(res == 1){
            resultVO.setCode(1);
            resultVO.setMsg("解锁成功");
        }else if(res == 0){
            resultVO.setCode(0);
            resultVO.setMsg("锁定成功");
        }else{
            resultVO.setCode(-1);
            resultVO.setMsg("操作失败");
        }
        return resultVO;
    }

    @ResponseBody
    @RequestMapping("/checkCompany")
    public ResultVO checkCompany(Integer companyId){
        ResultVO resultVO = new ResultVO();
        int res = companyService.checkAvaiable(companyId);
        if(res == 1){
            resultVO.setCode(1);
            resultVO.setMsg("解除权限成功");
        }else if(res == 0){
            resultVO.setCode(0);
            resultVO.setMsg("授予权限成功");
        }else{
            resultVO.setCode(-1);
            resultVO.setMsg("操作失败");
        }
        return resultVO;
    }

    @ResponseBody
    @RequestMapping("/informDeliverList")
    public TableResponseVO informDeliverList(QueryDeliverVO queryDeliverVO){
        TableResponseVO tableResponseVO = new TableResponseVO();
        Page<Deliver> page = deliverService.findDeliverList(queryDeliverVO);

        tableResponseVO.setRows(page.getContent());
        tableResponseVO.setTotal((int) page.getTotalElements());

        return tableResponseVO;
    }

    @ResponseBody
    @RequestMapping("/complaintList")
    public TableResponseVO complaintList(QueryComplaint queryComplaint){
        TableResponseVO tableResponseVO = new TableResponseVO();
        Page<Complaint> page = complaintService.findByQueryComplaint(queryComplaint);

        tableResponseVO.setRows(page.getContent());
        tableResponseVO.setTotal((int) page.getTotalElements());

        return tableResponseVO;
    }

    @ResponseBody
    @RequestMapping("/positionList")
    public TableResponseVO positionList(QueryPositionVO queryPositionVO){
        TableResponseVO tableResponseVO = new TableResponseVO();

        Page<Position> page = positionService.findByQueryPosition(queryPositionVO);

        tableResponseVO.setTotal((int) page.getTotalElements());
        tableResponseVO.setRows(page.getContent());
        return tableResponseVO;
    }

    @ResponseBody
    @RequestMapping("/downPast")
    public ResultVO downPast(){
        if(positionService.downAllPast()){
            return new ResultVO(1,"下线操作成功");
        }else {
            return new ResultVO(-1,"下线操作失败");
        }
    }

    @ResponseBody
    @RequestMapping("/lockPosition")
    public ResultVO lockPosition(int positionId){
        ResultVO resultVO = new ResultVO();
        int res = positionService.lock(positionId);
        if(res == 1){
            resultVO.setCode(1);
            resultVO.setMsg("解锁成功");
        }else if(res == 0){
            resultVO.setCode(0);
            resultVO.setMsg("锁定成功");
        }else{
            resultVO.setMsg("操作失败");
            resultVO.setCode(-1);
        }

        return resultVO;
    }

    @ResponseBody
    @RequestMapping("/positionTypeList")
    public List<JobType> positionTypeList(){
        List<JobType> jobTypes = jobTypeRepository.findAll();
        for (int i = 0;i < jobTypes.size();i++){
            JobType jobType = jobTypes.get(i);
            if(jobType.getParent() == null) jobType.setPid(0);
            else jobType.setPid(jobType.getParent().getId());
        }
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

    @ResponseBody
    @RequestMapping("/dictList")
    public List<Dict> dictList(){
        List<Dict> dicts = dictRepository.findAll();
        for (int i = 0;i < dicts.size();i++){
            List<DictItems> dictItemsList = dicts.get(i).getDict_items();
            for(int j = 0;j < dictItemsList.size();j++){
                dictItemsList.get(j).setPid(dicts.get(i).getId());
            }
        }
        return dicts;
    }

    @ResponseBody
    @RequestMapping("/saveDict")
    public ResultVO saveDict(Dict dict){
        ResultVO resultVO = new ResultVO();
        try {
            dictRepository.save(dict);
        } catch (Exception e) {
            e.printStackTrace();
            resultVO.setCode(0);
            resultVO.setMsg("保存dict失败");
            return resultVO;
        }
        resultVO.setCode(1);
        resultVO.setMsg("保存成功");
        return resultVO;
    }

    @ResponseBody
    @RequestMapping("/saveDictItem")
    public ResultVO saveDictItem(DictItems dictItems){
        ResultVO resultVO = new ResultVO();
        try {
            dictItemsService.saveDictItem(dictItems);
            resultVO.setCode(1);
            resultVO.setMsg("操作成功");
        } catch (Exception e) {
            e.printStackTrace();
            resultVO.setCode(0);
            resultVO.setMsg("操作失败");
            return resultVO;
        }
        return resultVO;
    }

    @ResponseBody
    @RequestMapping("/deleteDict")
    public ResultVO deleteDict(@RequestParam String ids,@RequestParam int level){

        String[] idList = ids.split(",");
        ResultVO resultVO = new ResultVO();
        try {
            for (String id:idList){
                if(level == 0) dictRepository.delete(Integer.valueOf(id));
                else dictItemsService.deleteById(Integer.valueOf(id));
            }
        } catch (Exception e) {
            e.printStackTrace();
            resultVO.setCode(0);
            resultVO.setMsg("删除失败");
            return resultVO;
        }
        resultVO.setCode(1);
        resultVO.setMsg("删除成功");
        return resultVO;
    }


}
