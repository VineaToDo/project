package com.version1.controller;

import com.version1.VO.*;
import com.version1.commons.utils.ControllerUtil;
import com.version1.commons.utils.JsonUtil;
import com.version1.entity.PersonalInfo;
import com.version1.entity.ResumeInfo;
import com.version1.entity.UserInfo;
import com.version1.service.ResumeService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.text.SimpleDateFormat;
import java.util.Date;

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
    private ResumeService resumeService;

    @GetMapping("/getResume")
    public String getResume() {
        UserInfo userInfo = (UserInfo) getSession().getAttribute("user");
        ResumeInfo resumeInfo = userInfo.getResumeInfo();
        ControllerUtil.addAllResume(getSession(),getModelMap(),resumeInfo);
        return "resume_view";
    }

    @PostMapping("/updatePersonal")
    public String updatePersonnal(PersonalInfo personalInfo) {
        ResumeInfo resumeInfo = getLoginUser().getResumeInfo();
        if(resumeInfo == null) resumeInfo = new ResumeInfo();
        resumeService.savePersonalInfo(personalInfo,resumeInfo,getLoginUser());

        ControllerUtil.addAllResume(getSession(),getModelMap(),resumeInfo);
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

        ControllerUtil.addAllResume(getSession(),getModelMap(),resumeInfo);

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

        ControllerUtil.addAllResume(getSession(),getModelMap(),resumeInfo);

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

        ControllerUtil.addAllResume(getSession(),getModelMap(),resumeInfo);

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

        ControllerUtil.addAllResume(getSession(),getModelMap(),resumeInfo);

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

        ControllerUtil.addAllResume(getSession(),getModelMap(),resumeInfo);

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

        ControllerUtil.addAllResume(getSession(),getModelMap(),resumeInfo);

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

        ControllerUtil.addAllResume(getSession(),getModelMap(),resumeInfo);

        return "resume_view";
    }

    @GetMapping("/delete/{deleteType}")
    public String deleteResumeInfo(@PathVariable String deleteType, @RequestParam(value = "id") int index){
        ResumeInfo resumeInfo = getLoginUser().getResumeInfo();

        resumeService.deleteJsonFiled(resumeInfo,deleteType,index);

        ControllerUtil.addAllResume(getSession(),getModelMap(),resumeInfo);

        return "resume_view";
    }

    @GetMapping("/edit/{editType}")
    public String insertOrUpdate(@PathVariable String editType, @RequestParam(value = "id", required = false) String index) {
        ResumeInfo resumeInfo = getLoginUser().getResumeInfo();
        switch (editType){
            case "education":
                if (resumeInfo != null && index != null) {
                    getModelMap().addAttribute("id", index);
                    getModelMap().addAttribute("education", JsonUtil.jsontoList(resumeInfo.getEducation(), EducationVO.class).get(Integer.parseInt(index)));
                }
                break;
            case "perInfo":
                if(resumeInfo != null && resumeInfo.getPersonalInfo() != null)
                    getModelMap().addAttribute(resumeInfo.getPersonalInfo());
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
        }
        return "/resume_edit/" + editType + "_edit";
    }

    @RequestMapping("/downloadResume")
    public String downloadResume(@RequestParam Integer resumeId){
        ResumeInfo resumeInfo = resumeService.getResumeById(resumeId);
        ControllerUtil.addAllResume(getSession(),getModelMap(),resumeInfo);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd-HHmmss");
        getResponse().setCharacterEncoding("UTF-8");
        getResponse().setContentType("application/msword");
        getResponse().addHeader("Content-Disposition", "attachment;filename="+ resumeInfo.getPersonalInfo().getName() + "_" + sdf.format(new Date()) + ".doc");
        return "resume_download";
    }
}
