package com.version1.controller;

import com.version1.VO.QueryPositionVO;
import com.version1.VO.ResultVO;
import com.version1.VO.TableResponseVO;
import com.version1.entity.*;
import com.version1.repository.*;
import com.version1.service.PositionService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

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
    private PositionRepository positionRepository;

    @Autowired
    private DeliverRepository deliverRepository;

    @Autowired
    private JobTypeRepository jobTypeRepository;

    @Autowired
    private PositionService positionService;

    /**
     * @Description 根据职位性质跳转列表
     * @Date 14:58 2018/5/15
     * @Param [property]
     * @return java.lang.String
     */
    @GetMapping("/position_review")
    public String goPositionList(@RequestParam String property){

        getModelMap().addAttribute("property",property);

        return "positions_list";
    }

    /**
     * @Description 职位管理列表页面跳转
     * @Date 14:57 2018/5/15
     * @Param []
     * @return java.lang.String
     */
    @GetMapping("/getPosition")
    public String getPosition(){
        if(interceptAvailable()) return "/enterprise/verify";
        return "/enterprise/positions_manage";
    }
    
    /**
     * @Description 职位浏览列表
     * @Date 14:56 2018/5/15
     * @Param [queryParamVO]
     * @return com.version1.VO.TableResponseVO
     */
    @ResponseBody
    @RequestMapping("/positionList")
    public TableResponseVO positionList(QueryPositionVO queryPositionVO){
        TableResponseVO tableResponseVO = new TableResponseVO();
        if(queryPositionVO.isCollect()) queryPositionVO.setUserId(getLoginUser().getId());
        Page<Position> page = positionService.findByQueryPosition(queryPositionVO);
        List<Position> positionList = page.getContent();
        if(positionList != null) {
            for (int i = 0; i < positionList.size(); i++) {
                Position position = positionList.get(i);
                position.setDegreeStr(((Map<Integer,DictItems>)getSession().getAttribute("eduDegreeDict")).get(position.getDegree()).getValue());
                position.setSalaryStr(((Map<Integer,DictItems>)getSession().getAttribute("salaryDict")).get(position.getSalary()).getValue());
            }
        }
        tableResponseVO.setTotal((int)page.getTotalElements());
        tableResponseVO.setRows(positionList);
        return tableResponseVO;
    }

    /**
     * @Description 职位详情
     * @Date 17:56 2018/5/24
     * @Param [positionId]
     * @return java.lang.String
     */
    @GetMapping("/positionDetail")
    public String positionDetail(@RequestParam int positionId){
        Position position = positionRepository.findOne(positionId);
        positionService.increaseHit(positionId);
        boolean isDelivered = false;
        boolean isCollected = false;
        UserInfo user = getLoginUser();

        if(user != null && user.getRole().getRole().equals("apply")){
            Deliver deliver = deliverRepository.findByResumeInfoAndPosition(getLoginUser().getResumeInfo(), position);
            if(deliver != null) isDelivered = true;

            if(getLoginUser().getPositions().contains(position)){
                isCollected = true;
            }
            getModelMap().addAttribute("isDelivered",isDelivered);
            getModelMap().addAttribute("isCollected",isCollected);
        }
        position.setSalaryStr(((Map<Integer,DictItems>)getSession().getAttribute("salaryDict")).get(position.getSalary()).getValue());
        position.setDegreeStr(((Map<Integer,DictItems>)getSession().getAttribute("eduDegreeDict")).get(position.getDegree()).getValue());
        position.getCompanyInfo().setProperty(((Map<Integer,DictItems>)getSession().getAttribute("propertyDict")).get(position.getCompanyInfo().getPropertyCode()).getValue());
        position.getCompanyInfo().setDimensions(((Map<Integer,DictItems>)getSession().getAttribute("dimensionsDict")).get(position.getCompanyInfo().getDimensionsCode()).getValue());
        getModelMap().addAttribute("position",position);

        return "positions_detail";
    }
    
    
    /**
     * @Description 职位管理模块列表
     * @Date 14:55 2018/5/15
     * @Param [queryParamVO]
     * @return com.version1.VO.TableResponseVO
     */
    @ResponseBody
    @RequestMapping("/positionManage")
    public TableResponseVO positionAllList(QueryPositionVO queryPositionVO){
        TableResponseVO tableResponseVO = new TableResponseVO();
        UserInfo userInfo = (UserInfo)getRequest().getSession().getAttribute("user");
        queryPositionVO.setCompanyId(userInfo.getCompanyInfo().getId());
        Page<Position> page = positionService.findByQueryPosition(queryPositionVO);
        tableResponseVO.setTotal((int)page.getTotalElements());
        tableResponseVO.setRows(page.getContent());
        return tableResponseVO;
    }

    @ResponseBody
    @RequestMapping("/publishPositions")
    public ResultVO publishPositions(@RequestParam String ids){
        ResultVO resultVO = new ResultVO();
        boolean res = positionService.publish(ids);

        if(res){
            resultVO.setCode(1);
            resultVO.setMsg("发布成功");
        }else {
            resultVO.setCode(0);
            resultVO.setMsg("发布失败");
        }
        return resultVO;
    }

    @ResponseBody
    @RequestMapping("/offlinePositions")
    public ResultVO offlinePositions(@RequestParam String ids){
        ResultVO resultVO = new ResultVO();
        boolean res = positionService.offline(ids);

        if(res){
            resultVO.setCode(1);
            resultVO.setMsg("下线成功");
        }else {
            resultVO.setCode(0);
            resultVO.setMsg("下线失败");
        }
        return resultVO;
    }

    @ResponseBody
    @RequestMapping("/deletePositions")
    public ResultVO deletePositions(@RequestParam String ids){
        ResultVO resultVO = new ResultVO();
        boolean res = positionService.delete(ids);

        if(res){
            resultVO.setCode(1);
            resultVO.setMsg("删除成功");
        }else {
            resultVO.setCode(0);
            resultVO.setMsg("删除失败");
        }
        return resultVO;
    }

    /**
     * @Description 提交更新职位信息
     * @Date 14:55 2018/5/15
     * @Param [position, bindingResult]
     * @return java.lang.String
     */
    @ResponseBody
    @PostMapping("/updatePostion")
    public ResultVO updatePosition(Position position, BindingResult bindingResult){
        if (position.getId() == null){
            UserInfo userInfo = (UserInfo)getSession().getAttribute("user");
            position.setCompanyInfo(userInfo.getCompanyInfo());
        }
        try {
            int res = positionService.updateOrNewPosition(position);
            if(res == 0){
                if(position.getState() == 1) return new ResultVO(0,"发布成功");
                else return new ResultVO(0,"保存成功");
            }else
                return new ResultVO(1,"修改成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultVO(-1,"操作失败");
        }
//        return "/enterprise/positions_manage";
    }
    
    /**
     * @Description 准备编辑职位信息
     * @Date 14:55 2018/5/15
     * @Param [id]
     * @return java.lang.String
     */
    @RequestMapping("/editPosition")
    public String editPrepare(@RequestParam(required = false) Integer id){
        if(interceptAvailable()) return "/enterprise/verify";

        if(id != null){
            Position position = positionRepository.findOne(id);
            getModelMap().addAttribute("position",position);
        }
        
        List<JobType> jobTypes = jobTypeRepository.findByParent(null);

        getSession().setAttribute("jobTypes",jobTypes);

        UserInfo userInfo = (UserInfo)getSession().getAttribute("user");
        getModelMap().addAttribute("deptList",userInfo.getCompanyInfo().getDepartments());

        return "/enterprise/job_publish";
    }

}
