package com.version1.controller;

import com.version1.VO.EducationVO;
import com.version1.VO.WorkExVO;
import com.version1.commons.enums.EduDgreeEnum;
import com.version1.commons.utils.JsonUtil;
import com.version1.entity.PersonalInfo;
import com.version1.entity.ResumeInfo;
import com.version1.entity.UserInfo;
import com.version1.repository.ResumeRepository;
import com.version1.repository.UserRepository;
import com.version1.service.ResumeService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.Arrays;

/**
 * @ClassName ResumeController
 * @Description TODO
 * @Date 2018/4/21 14:29
 * @Version 1.0
 **/
@Controller
@RequestMapping("/resume")
@Slf4j
public class ResumeController extends BaseController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ResumeRepository resumeRepository;

    @Autowired
    private ResumeService resumeService;
    /**
     * @Description 获取已登录用户
     * @Date 23:37 2018/4/28
     * @Param []
     * @return com.version1.entity.UserInfo
     */
    private UserInfo getLoginUser(){
        return (UserInfo) getRequest().getSession().getAttribute("user");
    }

    @GetMapping("/jsonInfo")
    public String getJsonInfo() {
        getModelMap().addAttribute("id",0);
//        ResumeInfo resumeInfo = resumeRepository.findOne(1);
        return "/test";
    }


    @PostMapping("/updatePersonal")
    public String updatePersonnal(@ModelAttribute PersonalInfo personalInfo) {
        ResumeInfo resumeInfo = getLoginUser().getResumeInfo();
        resumeInfo.setPersonalInfo(personalInfo);
        resumeRepository.save(resumeInfo);
        getModelMap().addAttribute(resumeInfo.getPersonalInfo());
        getModelMap().addAttribute("educationList",JsonUtil.jsontoList(resumeInfo.getEducation(), EducationVO.class));
        return "resume_view";
    }

    @GetMapping("/getResume")
    public String getResume() {
        try {
            UserInfo userInfo = userRepository.findByUserName("test01");
            HttpSession session = getRequest().getSession();
            if (session.getAttribute("user") == null){
                session.setAttribute("user",userInfo);
            }
        } catch (Exception e) {
            log.info("登录失败");
            e.printStackTrace();
            return "error";
        }
        log.info("登录成功");
        UserInfo userInfo = (UserInfo) getRequest().getSession().getAttribute("user");
        ResumeInfo resumeInfo = userInfo.getResumeInfo();
        getModelMap().addAttribute(resumeInfo.getPersonalInfo());
        getModelMap().addAttribute("educationList", JsonUtil.jsontoList(resumeInfo.getEducation(), EducationVO.class));

        return "resume_view";
    }

    @PostMapping("/addEducation")
    public String addEducation(@Valid EducationVO educationVO, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            log.info(bindingResult.getFieldError().getDefaultMessage());
            return "error";
        }
        ResumeInfo resumeInfo = getLoginUser().getResumeInfo();
        resumeService.saveJsonFiled(resumeInfo,"Education",educationVO);

        getModelMap().addAttribute(resumeInfo.getPersonalInfo());
        getModelMap().addAttribute("educationList", JsonUtil.jsontoList(resumeInfo.getEducation(), EducationVO.class));
        return "resume_view";
    }

    @GetMapping("/edit/{editType}")
    public String insertOrUpdate(@PathVariable String editType, @RequestParam(value = "id", required = false) String index) {
        UserInfo userInfo = (UserInfo) getRequest().getSession().getAttribute("user");
        ResumeInfo resumeInfo = userInfo.getResumeInfo();
        switch (editType){
            case "education":
                if (index != null) {
                    getModelMap().addAttribute("id", index);
                    getModelMap().addAttribute("education", JsonUtil.jsontoList(resumeInfo.getEducation(), EducationVO.class).get(Integer.parseInt(index)));
                }
                getModelMap().addAttribute("eduEnum", Arrays.asList(EduDgreeEnum.values()));
                break;
            case "perInfo":
                getModelMap().addAttribute(resumeInfo.getPersonalInfo());
                break;
            case "jobIntension":
                break;
            case "workExper":
                if(index != null){
                    getModelMap().addAttribute("id",index);
                    getModelMap().addAttribute("workExper",JsonUtil.jsontoList(resumeInfo.getWorkExperience(),WorkExVO.class).get(Integer.parseInt(index)));
                }
                break;
            case "":

                break;
        }
        return "/resume_edit/" + editType + "_edit";
    }
}
