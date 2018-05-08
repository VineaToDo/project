package com.version1.commons.utils;

import com.version1.VO.*;
import com.version1.entity.ResumeInfo;
import org.springframework.ui.ModelMap;

/**
 * @ClassName ControllerUtil
 * @Description TODO
 * @Date 2018/5/2 20:03
 * @Version 1.0
 */
public class ControllerUtil {

    public static void addAllResume(ModelMap modelMap, ResumeInfo resumeInfo){

        modelMap.addAttribute(resumeInfo.getPersonalInfo());
        modelMap.addAttribute("educationList",JsonUtil.jsontoList(resumeInfo.getEducation(),EducationVO.class));
        modelMap.addAttribute("workList",JsonUtil.jsontoList(resumeInfo.getWorkExperience(),WorkExperienceVO.class));
        modelMap.addAttribute("internshipList",JsonUtil.jsontoList(resumeInfo.getInternship(),WorkExperienceVO.class));
        modelMap.addAttribute("trainingList",JsonUtil.jsontoList(resumeInfo.getTraining(),TrainingVO.class));
        modelMap.addAttribute("languageList",JsonUtil.jsontoList(resumeInfo.getLanguage(),LanguageVO.class));
        modelMap.addAttribute("credentialList",JsonUtil.jsontoList(resumeInfo.getCredential(),CredentialVO.class));
        modelMap.addAttribute("skillList",JsonUtil.jsontoList(resumeInfo.getSkill(),SkillVO.class));
        modelMap.addAttribute("projectList",JsonUtil.jsontoList(resumeInfo.getProject(),ProjectVO.class));

    }
}
