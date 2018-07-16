package com.version1.service;

import com.version1.VO.IdGetter;
import com.version1.entity.PersonalInfo;
import com.version1.entity.ResumeInfo;
import com.version1.entity.UserInfo;

public interface ResumeService {

    ResumeInfo getResumeById(Integer id);

    boolean savePersonalInfo(PersonalInfo personalInfo, ResumeInfo resumeInfo, UserInfo userInfo);

    //通过反射和泛型对类型为Json的字段值进行相应的插入或更新
    <T extends IdGetter> boolean saveJsonFiled(ResumeInfo resumeInfo, String filedName, T t);


    boolean deleteJsonFiled(ResumeInfo resumeInfo, String deleteType,int index);


}
