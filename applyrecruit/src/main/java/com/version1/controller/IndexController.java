package com.version1.controller;

import com.version1.VO.*;
import com.version1.entity.JobType;
import com.version1.entity.Position;
import com.version1.entity.UserInfo;
import com.version1.repository.JobTypeRepository;
import com.version1.service.ComplaintService;
import com.version1.service.DeliverService;
import com.version1.service.PositionService;
import com.version1.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @ClassName IndexController
 * @Description TODO
 * @Date 2018/5/13 22:30
 * @Version 1.0
 */
@Controller
@RequestMapping("/index")
@Slf4j
public class IndexController extends BaseController {

    @Autowired
    private UserService userService;

    @Autowired
    private PositionService positionService;

    @Autowired
    private JobTypeRepository jobTypeRepository;

    @Autowired
    private DeliverService deliverService;

    @Autowired
    private ComplaintService complaintService;

    @RequestMapping("/")
    public String index(){
        List<JobType> jobTypes = jobTypeRepository.findByParent(null);
        List<Position> topPositions = positionService.findTopPositions();
        getModelMap().addAttribute("jobTypes",jobTypes);
        getModelMap().addAttribute("topPositions",topPositions);
        return "index";
    }

    @GetMapping("/setting")
    public String setting(){

        return "setting";
    }


    @GetMapping("/getCollectPosition")
    public String getCollectPosition(){

        getModelMap().addAttribute("collect",true);

        return "positions_list";
    }

    @GetMapping("/getReply")
    public String getReply(){
        List<MessageVO> messageVOList = deliverService.getMessageTip(getLoginUser().getResumeInfo());
        getModelMap().addAttribute("messageList",messageVOList);
        return "reply_list";
    }


    @GetMapping("/getPositionsByType")
    public String getPositionsByType(@RequestParam int typeId){

        getModelMap().addAttribute("typeId",typeId);

        return "positions_list";
    }

    @PostMapping("/searchPosition")
    public String searchPosition(String key){
        getModelMap().addAttribute("key",key);
        return "positions_list";
    }

    @ResponseBody
    @RequestMapping("/collectPosition")
    public ResultVO collectPosition(@RequestParam int positionId){
        ResultVO resultVO = new ResultVO();
        UserInfo userInfo = getLoginUser();
        try {
            if(userService.collectPosition(userInfo,positionId)){
                resultVO.setCode(1);
                resultVO.setMsg("收藏成功");
//                resultVO.setData("收藏成功");
            }else {
                resultVO.setCode(2);
                resultVO.setMsg("已取消收藏");
//                resultVO.setData("取消收藏成功");
            }
//            getSession().setAttribute("user",userInfo);
//            resultVO.setData(userInfo);
        } catch (Exception e) {
            resultVO.setCode(0);
            resultVO.setMsg("收藏失败");
            e.printStackTrace();
            return resultVO;
        }
        return resultVO;
    }

    @ResponseBody
    @RequestMapping("/informPosition")
    public ResultVO informPosition(@RequestParam int positionId,@RequestParam String reason){
        ResultVO resultVO = new ResultVO();
        boolean res = complaintService.informPosition(positionId,(UserInfo)getSession().getAttribute("user"),reason);
        if(res){
            resultVO.setCode(1);
            resultVO.setMsg("举报成功");
        }else {
            resultVO.setCode(0);
            resultVO.setMsg("举报失败");
        }
        return resultVO;
    }

}
