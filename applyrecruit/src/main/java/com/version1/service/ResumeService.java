package com.version1.service;

import com.version1.VO.IdGetter;
import com.version1.entity.ResumeInfo;

public interface ResumeService {


    //通过反射和泛型对类型为Json的字段值进行相应的插入或更新
    <T extends IdGetter> boolean saveJsonFiled(ResumeInfo resumeInfo, String filedName, T t);


    boolean deleteJsonFiled(ResumeInfo resumeInfo, String deleteType,int index);


}
