package com.version1.commons.utils;

import com.version1.VO.*;
import com.version1.entity.DictItems;
import com.version1.entity.PersonalInfo;
import com.version1.entity.ResumeInfo;
import org.springframework.ui.ModelMap;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * @ClassName ControllerUtil
 * @Description TODO
 * @Date 2018/5/2 20:03
 * @Version 1.0
 */
public class ControllerUtil {

    public static void addAllResume(HttpSession session,ModelMap modelMap, ResumeInfo resumeInfo){
        if(resumeInfo == null) return;

        if(resumeInfo.getPersonalInfo() != null) {
            PersonalInfo personalInfo = resumeInfo.getPersonalInfo();
            personalInfo.setPoliticsValue(getDictValue(session, "politicsDict", personalInfo.getPolitics()));
            personalInfo.setMaritalValue(getDictValue(session, "maritalDict", personalInfo.getMarital()));
            modelMap.addAttribute(personalInfo);
        }
        if(resumeInfo.getEducation() != null) {
            List<EducationVO> educationVOList = JsonUtil.jsontoList(resumeInfo.getEducation(), EducationVO.class);
            for (int i = 0; i < educationVOList.size(); i++) {
                EducationVO educationVO = educationVOList.get(i);
                educationVO.setDegreeValue(getDictValue(session, "eduDegreeDict", educationVO.getDegree()));
            }
            modelMap.addAttribute("educationList", educationVOList);
        }
        if(resumeInfo.getWorkExperience() != null) {
            List<WorkExperienceVO> workExperienceVOList = JsonUtil.jsontoList(resumeInfo.getWorkExperience(), WorkExperienceVO.class);
            for (int i = 0; i < workExperienceVOList.size(); i++) {
                WorkExperienceVO workExperienceVO = workExperienceVOList.get(i);
                workExperienceVO.setPropertyValue(getDictValue(session, "propertyDict", workExperienceVO.getProperty()));
                workExperienceVO.setDimensionsValue((getDictValue(session, "dimensionsDict", workExperienceVO.getDimensions())));
                workExperienceVO.setSalaryValue(getDictValue(session, "salaryDict", workExperienceVO.getSalary()));
            }
            modelMap.addAttribute("workList",workExperienceVOList);
        }
        if(resumeInfo.getInternship() != null) {
            List<WorkExperienceVO> internshipList = JsonUtil.jsontoList(resumeInfo.getInternship(), WorkExperienceVO.class);
            for (int i = 0; i < internshipList.size(); i++) {
                WorkExperienceVO internship = internshipList.get(i);
                internship.setDimensionsValue((getDictValue(session, "dimensionsDict", internship.getDimensions())));
                internship.setPropertyValue(getDictValue(session, "propertyDict", internship.getProperty()));
                internship.setSalaryValue(getDictValue(session, "salaryDict", internship.getSalary()));
            }
            modelMap.addAttribute("internshipList", internshipList);
        }
        if(resumeInfo.getTraining() != null) {
            modelMap.addAttribute("trainingList", JsonUtil.jsontoList(resumeInfo.getTraining(), TrainingVO.class));
        }

        if(resumeInfo.getLanguage() != null) {
            List<LanguageVO> languageVOList = JsonUtil.jsontoList(resumeInfo.getLanguage(), LanguageVO.class);
            for (int i = 0; i < languageVOList.size(); i++) {
                LanguageVO languageVO = languageVOList.get(i);
                languageVO.setNameValue(getDictValue(session, "languageDict", languageVO.getName()));
            }
            modelMap.addAttribute("languageList", languageVOList);
        }
        if(resumeInfo.getCredential() != null) modelMap.addAttribute("credentialList",JsonUtil.jsontoList(resumeInfo.getCredential(),CredentialVO.class));
        if(resumeInfo.getSkill() != null) modelMap.addAttribute("skillList",JsonUtil.jsontoList(resumeInfo.getSkill(),SkillVO.class));
        if(resumeInfo.getProject() != null) modelMap.addAttribute("projectList",JsonUtil.jsontoList(resumeInfo.getProject(),ProjectVO.class));
    }

    public static String getDictValue(HttpSession session,String dict,int code){
        String value = ((Map<Integer,DictItems>)session.getAttribute(dict)).get(code).getValue();
        return value;
    }

}
