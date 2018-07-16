package com.version1.controller;

import com.version1.VO.QueryDeliverVO;
import com.version1.VO.ResultVO;
import com.version1.VO.TableResponseVO;
import com.version1.commons.utils.ControllerUtil;
import com.version1.entity.Deliver;
import com.version1.repository.DeliverRepository;
import com.version1.repository.PositionRepository;
import com.version1.service.DeliverService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;

/**
 * @ClassName DeliverController
 * @Description TODO
 * @Date 2018/5/15 21:37
 * @Version 1.0
 */
@Controller
@RequestMapping("/deliver")
public class DeliverController extends BaseController {

    @Autowired
    private DeliverService deliverService;

    @Autowired
    private DeliverRepository deliverRepository;

    @Autowired
    private PositionRepository positionRepository;

    @ResponseBody
    @RequestMapping("/pushResume")
    public ResultVO pushResume(@RequestParam int positionId){
        ResultVO resultVO = new ResultVO();
        Deliver deliver = new Deliver();
        try {
            deliver.setResumeInfo(getLoginUser().getResumeInfo());
            deliver.setPosition(positionRepository.findOne(positionId));
            deliverRepository.save(deliver);
            resultVO.setCode(1);
            resultVO.setMsg("投递成功");
        } catch (Exception e) {
            e.printStackTrace();
            resultVO.setCode(0);
            resultVO.setMsg("投递失败");
            return resultVO;
        }
        return resultVO;
    }

    @GetMapping("/goDeliverList")
    public String goDeliverList(){
        if(interceptAvailable()) return "/enterprise/verify";
        return "/enterprise/resume_manage";
    }

    @GetMapping("/goCollectionList")
    public String goCollectionList(){
        if(interceptAvailable()) return "/enterprise/verify";
        return "/enterprise/resume_collection";
    }

    @GetMapping("/goDisposeList")
    public String goDisposeList(){
        if(interceptAvailable()) return "/enterprise/verify";
        return "/enterprise/resume_dispose";
    }

    @ResponseBody
    @RequestMapping("/deliverList")
    public TableResponseVO deliverList(QueryDeliverVO queryDeliverVO){
        TableResponseVO tableResponseVO = new TableResponseVO();
        if(getLoginUser().getRole().getRole().equals("recruit")){
            queryDeliverVO.setCompanyId(getLoginUser().getCompanyInfo().getId());
        }
        Page<Deliver> page = deliverService.findDeliverList(queryDeliverVO);

        tableResponseVO.setTotal((int)page.getTotalElements());
        tableResponseVO.setRows(page.getContent());

        return tableResponseVO;
    }

    @RequestMapping("/getDeliver")
    public String getDeliver(@RequestParam Integer deliverId){
        Deliver deliver = deliverService.getDeliverById(deliverId);

        ControllerUtil.addAllResume(getSession(),getModelMap(),deliver.getResumeInfo());
        getModelMap().addAttribute("deliverId",deliver.getId());
        getModelMap().addAttribute("resumeId",deliver.getResumeInfo().getId());
        getModelMap().addAttribute("collected",deliver.getIsCollected());
        getModelMap().addAttribute("available",deliver.getAvailable());
        getModelMap().addAttribute("position",deliver.getPosition());

        return "/enterprise/resume_detail";
    }
    @RequestMapping("/downloadDeliver")
    public String downloadDeliver(@RequestParam Integer deliverId) {
        Deliver deliver = deliverService.getDeliverById(deliverId);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        getResponse().setCharacterEncoding("UTF-8");
        getResponse().setContentType("application/msword");
        getResponse().addHeader("Content-Disposition", "attachment;filename="+ deliver.getResumeInfo().getId() + "_" + deliver.getResumeInfo().getPersonalInfo().getName() + "_" + sdf.format(deliver.getCreatedTime()) + ".doc");

        ControllerUtil.addAllResume(getSession(),getModelMap(),deliver.getResumeInfo());
        getModelMap().addAttribute("available",deliver.getAvailable());
        getModelMap().addAttribute("position",deliver.getPosition());

        return "/enterprise/resume_download";
    }

    @ResponseBody
    @RequestMapping("/collectDeliver")
    public ResultVO collectDeliver(@RequestParam Integer deliverId){
        ResultVO resultVO = new ResultVO();
        boolean res = deliverService.collectDeliver(deliverId);
        if(res){
            resultVO.setCode(1);
            resultVO.setMsg("收藏成功");
        }else {
            resultVO.setCode(0);
            resultVO.setMsg("收藏失败");
        }
        return resultVO;
    }

    @ResponseBody
    @RequestMapping("/feedback")
    public ResultVO feedback(Deliver deliver){
        ResultVO resultVO = new ResultVO();
        boolean res = deliverService.feedback(deliver);
        if(res){
            resultVO.setCode(1);
            resultVO.setMsg("反馈成功");
        }else {
            resultVO.setCode(0);
            resultVO.setMsg("反馈失败");
        }
        return resultVO;
    }

    @ResponseBody
    @RequestMapping("/inform")
    public ResultVO inform(Deliver deliver){
        ResultVO resultVO = new ResultVO();
        boolean res = deliverService.inform(deliver);
        if(res){
            resultVO.setCode(1);
            resultVO.setMsg("举报成功");
        }else {
            resultVO.setMsg("举报失败");
            resultVO.setCode(0);
        }
        return resultVO;
    }

}
