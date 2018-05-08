package com.version1.controller;

import com.version1.VO.*;
import com.version1.commons.utils.ControllerUtil;
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

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

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

    @GetMapping("/getResume")
    public String getResume() {
        try {
            UserInfo userInfo = userRepository.findByUserName("user");
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

        ControllerUtil.addAllResume(getModelMap(),resumeInfo);

        return "resume_view";
    }

    @PostMapping("/updatePersonal")
    public String updatePersonnal(@ModelAttribute PersonalInfo personalInfo) {
        ResumeInfo resumeInfo = getLoginUser().getResumeInfo();
        resumeInfo.setPersonalInfo(personalInfo);
        resumeRepository.save(resumeInfo);

        ControllerUtil.addAllResume(getModelMap(),resumeInfo);
        return "resume_view";
    }

    @PostMapping("/updateEducation")
    public String updateEducation(@Valid EducationVO educationVO, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            log.info(bindingResult.getFieldError().getDefaultMessage());
            return "error";
        }
        ResumeInfo resumeInfo = getLoginUser().getResumeInfo();
        resumeService.saveJsonFiled(resumeInfo,"Education",educationVO);

        ControllerUtil.addAllResume(getModelMap(),resumeInfo);

//        getModelMap().addAttribute(resumeInfo.getPersonalInfo());
//        getModelMap().addAttribute("educationList", JsonUtil.jsontoList(resumeInfo.getEducation(), EducationVO.class));
//        getModelMap().addAttribute("workList",JsonUtil.jsontoList(resumeInfo.getWorkExperience(),WorkExperienceVO.class));
        return "resume_view";
    }

    @PostMapping("/updateWork")
    public String updateWork(@Valid WorkExperienceVO workExperienceVO, BindingResult bindingResult){
        if(bindingResult.hasErrors()){
            log.info(bindingResult.getFieldError().getDefaultMessage());
            return "error";
        }
        ResumeInfo resumeInfo = getLoginUser().getResumeInfo();
        resumeService.saveJsonFiled(resumeInfo, workExperienceVO.getIsInternship() == 1?"Internship":"WorkExperience", workExperienceVO);

        ControllerUtil.addAllResume(getModelMap(),resumeInfo);

//        getModelMap().addAttribute(resumeInfo.getPersonalInfo());
//        getModelMap().addAttribute("educationList",JsonUtil.jsontoList(resumeInfo.getEducation(),EducationVO.class));
//        getModelMap().addAttribute("workList",JsonUtil.jsontoList(resumeInfo.getWorkExperience(),WorkExperienceVO.class));
//        getModelMap().addAttribute("internshipList",JsonUtil.jsontoList(resumeInfo.getInternship(),WorkExperienceVO.class));

        return "resume_view";
    }
    @PostMapping("/updateTraining")
    public String updateTraining(@Valid TrainingVO trainingVO,BindingResult bindingResult){
        if(bindingResult.hasErrors()){
            log.info(bindingResult.getFieldError().getDefaultMessage());
            return "error";
        }
        ResumeInfo resumeInfo = getLoginUser().getResumeInfo();
        resumeService.saveJsonFiled(resumeInfo,"Training",trainingVO);

        ControllerUtil.addAllResume(getModelMap(),resumeInfo);

        return "resume_view";
    }
    @PostMapping("/updateLanguage")
    public String updateLanguage(@Valid LanguageVO languageVO,BindingResult bindingResult){
        if(bindingResult.hasErrors()){
            log.info(bindingResult.getFieldError().getDefaultMessage());
            return "error";
        }
        ResumeInfo resumeInfo = getLoginUser().getResumeInfo();
        resumeService.saveJsonFiled(resumeInfo,"Language",languageVO);

        ControllerUtil.addAllResume(getModelMap(),resumeInfo);

        return "resume_view";
    }

    @PostMapping("/updateCredential")
    public String updateCredential(@Valid CredentialVO credentialVO,BindingResult bindingResult){
        if(bindingResult.hasErrors()){
            log.info(bindingResult.getFieldError().getDefaultMessage());
            return "error";
        }
        ResumeInfo resumeInfo = getLoginUser().getResumeInfo();
        resumeService.saveJsonFiled(resumeInfo,"Credential",credentialVO);

        ControllerUtil.addAllResume(getModelMap(),resumeInfo);

        return "resume_view";
    }
    @PostMapping("/updateSkill")
    public String updateSkill(@Valid SkillVO skillVO,BindingResult bindingResult){
        if(bindingResult.hasErrors()){
            log.info(bindingResult.getFieldError().getDefaultMessage());
            return "error";
        }
        ResumeInfo resumeInfo = getLoginUser().getResumeInfo();
        resumeService.saveJsonFiled(resumeInfo,"Skill",skillVO);

        ControllerUtil.addAllResume(getModelMap(),resumeInfo);

        return "resume_view";
    }
    @PostMapping("/updateProject")
    public String updateProject(@Valid ProjectVO projectVO,BindingResult bindingResult){
        if(bindingResult.hasErrors()){
            log.info(bindingResult.getFieldError().getDefaultMessage());
            return "error";
        }
        ResumeInfo resumeInfo = getLoginUser().getResumeInfo();
        resumeService.saveJsonFiled(resumeInfo,"Project",projectVO);

        ControllerUtil.addAllResume(getModelMap(),resumeInfo);

        return "resume_view";
    }

    @GetMapping("/delete/{deleteType}")
    public String deleteResumeInfo(@PathVariable String deleteType, @RequestParam(value = "id") int index){
        ResumeInfo resumeInfo = getLoginUser().getResumeInfo();

        resumeService.deleteJsonFiled(resumeInfo,deleteType,index);

        ControllerUtil.addAllResume(getModelMap(),resumeInfo);

        return "resume_view";
    }



    @GetMapping("/edit/{editType}")
    public String insertOrUpdate(@PathVariable String editType, @RequestParam(value = "id", required = false) String index) {
        ResumeInfo resumeInfo = getLoginUser().getResumeInfo();
        switch (editType){
            case "education":
                if (index != null) {
                    getModelMap().addAttribute("id", index);
                    getModelMap().addAttribute("education", JsonUtil.jsontoList(resumeInfo.getEducation(), EducationVO.class).get(Integer.parseInt(index)));
                }
//                getModelMap().addAttribute("eduEnum", Arrays.asList(EduDgreeEnum.values()));
                break;
            case "perInfo":
                getModelMap().addAttribute(resumeInfo.getPersonalInfo());
                break;
            case "jobIntension":
                break;
            case "work":
                if(index != null){
                    getModelMap().addAttribute("id",index);
                    getModelMap().addAttribute("work",JsonUtil.jsontoList(resumeInfo.getWorkExperience(),WorkExperienceVO.class).get(Integer.parseInt(index)));
                }
                break;
            case "internship":
                if(index != null){
                    getModelMap().addAttribute("id",index);
                    getModelMap().addAttribute("work",JsonUtil.jsontoList(resumeInfo.getInternship(),WorkExperienceVO.class).get(Integer.parseInt(index)));
                }
                getModelMap().addAttribute("internship","internship");
                editType = "work";
                break;
            case "training":
                if (index != null){
                    getModelMap().addAttribute("id",index);
                    getModelMap().addAttribute("training",JsonUtil.jsontoList(resumeInfo.getTraining(),TrainingVO.class).get(Integer.parseInt(index)));
                }
                break;
            case "language":
                if (index != null){
                    getModelMap().addAttribute("id",index);
                    getModelMap().addAttribute("language",JsonUtil.jsontoList(resumeInfo.getLanguage(),LanguageVO.class).get(Integer.parseInt(index)));
                }
                break;
            case "credential":
                if (index != null){
                    getModelMap().addAttribute("id",index);
                    getModelMap().addAttribute("credential",JsonUtil.jsontoList(resumeInfo.getCredential(),CredentialVO.class).get(Integer.parseInt(index)));
                }
                break;
            case "skill":
                if(index != null){
                    getModelMap().addAttribute("id",index);
                    getModelMap().addAttribute("skill",JsonUtil.jsontoList(resumeInfo.getSkill(),SkillVO.class).get(Integer.parseInt(index)));
                }
                break;
            case "project":
                if(index != null){
                    getModelMap().addAttribute("id",index);
                    getModelMap().addAttribute("projectEx",JsonUtil.jsontoList(resumeInfo.getProject(),ProjectVO.class).get(Integer.parseInt(index)));
                }
                break;
            case "":

                break;
        }
        return "/resume_edit/" + editType + "_edit";
    }
}
