package com.version1.service.impl;

import com.version1.VO.*;
import com.version1.commons.utils.JsonUtil;
import com.version1.commons.utils.StringUtil;
import com.version1.entity.ResumeInfo;
import com.version1.repository.ResumeRepository;
import com.version1.service.ResumeService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

/**
 * @ClassName ResumeServiceImpl
 * @Description TODO
 * @Date 2018/4/28 22:48
 * @Version 1.0
 */
@Service
@Transactional
@Slf4j
public class ResumeServiceImpl implements ResumeService {

    @Autowired
    private ResumeRepository resumeRepository;

    /**
     * @Description 通过反射和泛型对类型为Json的字段值进行相应的插入或更新
     * @Date 22:59 2018/4/28
     * @Param [resumeInfo, filedName, t]
     * @return com.version1.entity.ResumeInfo
     */
    @Override
    public <T extends IdGetter> boolean saveJsonFiled(ResumeInfo resumeInfo, String filedName, T t) {
        try {
            Method method = resumeInfo.getClass().getMethod("get" + filedName);
            String val = (String) method.invoke(resumeInfo);
            List listmodel;
            if (t.getId()==null){
                if(val == null){
                    listmodel = new ArrayList();
                }else {
                    listmodel = JsonUtil.jsontoList(val,t.getClass());
                }
                listmodel.add(t);
            }else {
                listmodel = JsonUtil.jsontoList(val,t.getClass());
                listmodel.set(t.getId(),t);
            }

            resumeInfo.getClass().getMethod("set"+filedName,String.class).invoke(resumeInfo,JsonUtil.toJsonString(listmodel));
            resumeRepository.save(resumeInfo);

        } catch (NoSuchMethodException | SecurityException | IllegalAccessException | IllegalArgumentException | InvocationTargetException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    @Override
    public boolean deleteJsonFiled(ResumeInfo resumeInfo, String deleteType, int index) {

        deleteType = StringUtil.toUpperCaseInitial(deleteType);
        try {
            Method method = resumeInfo.getClass().getMethod("get" + deleteType);
            String val = (String) method.invoke(resumeInfo);
            List listmodel = JsonUtil.jsontoList(val,Class.forName("com.version1.VO."+(deleteType.equals("internship")?"WorkExperience":deleteType)+"VO"));

            listmodel.remove(index);

            resumeInfo.getClass().getMethod("set"+deleteType,String.class).invoke(resumeInfo,JsonUtil.toJsonString(listmodel));
            resumeRepository.save(resumeInfo);

        } catch (NoSuchMethodException | SecurityException | IllegalAccessException | IllegalArgumentException | InvocationTargetException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }


        return true;
    }
}
