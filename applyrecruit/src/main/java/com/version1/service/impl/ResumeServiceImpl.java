package com.version1.service.impl;

import com.version1.VO.*;
import com.version1.commons.utils.JsonUtil;
import com.version1.commons.utils.StringUtil;
import com.version1.entity.PersonalInfo;
import com.version1.entity.ResumeInfo;
import com.version1.entity.UserInfo;
import com.version1.repository.PersonalRepository;
import com.version1.repository.ResumeRepository;
import com.version1.repository.UserRepository;
import com.version1.service.ResumeService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.Modifying;
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
@Transactional(readOnly = true)
@Slf4j
public class ResumeServiceImpl implements ResumeService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ResumeRepository resumeRepository;

    @Autowired
    private PersonalRepository personalRepository;


    @Override
    public ResumeInfo getResumeById(Integer id) {
        ResumeInfo resumeInfo = null;
        try {
            resumeInfo = resumeRepository.findOne(id);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return resumeInfo;
    }

    @Override
    @Modifying(clearAutomatically = true)
    @Transactional
    public boolean savePersonalInfo(PersonalInfo personalInfo, ResumeInfo resumeInfo, UserInfo userInfo) {
        try {
            if(personalInfo.getId() == null){
                resumeInfo.setPersonalInfo(personalRepository.save(personalInfo));
                userInfo.setResumeInfo(resumeRepository.save(resumeInfo));
                userRepository.save(userInfo);
            }else {
                PersonalInfo personalInfoOld = personalRepository.findOne(personalInfo.getId());
                BeanUtils.copyProperties(personalInfo,personalInfoOld);
                resumeInfo.setPersonalInfo(personalInfoOld);
                userInfo.setResumeInfo(resumeInfo);
                userRepository.save(userInfo);
            }
        } catch (BeansException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    /**
     * @Description 通过反射和泛型对类型为Json的字段值进行相应的插入或更新
     * @Date 22:59 2018/4/28
     * @Param [resumeInfo 目标操作简历对象, filedName 需要操作的属性名, t 对应属性名的泛型对象，从前台获得的值]
     * @return com.version1.entity.ResumeInfo
     */
    @Override
    @Modifying(clearAutomatically = true)
    @Transactional
    public <T extends IdGetter> boolean saveJsonFiled(ResumeInfo resumeInfo, String filedName, T t) {
        try {
            //获取resume中对应field属性的原值
            Method method = resumeInfo.getClass().getMethod("get" + filedName);
            String val = (String) method.invoke(resumeInfo);
            List listmodel;
            if (t.getId()==null){
                //当t的id为null时，是field记录新增
                if(val == null){
                    //当val为null时，表示该项field第一次新增记录；否则表示该field存在原记录，先进行Json转化
                    listmodel = new ArrayList();
                }else {
                    listmodel = JsonUtil.jsontoList(val,t.getClass());
                }
                //新增记录
                listmodel.add(t);
            }else {
                //根据t的id更改json对应记录
                listmodel = JsonUtil.jsontoList(val,t.getClass());
                listmodel.set(t.getId(),t);
            }
            //将List转回json并设回，执行数据库保存操作
            resumeInfo.getClass().getMethod("set"+filedName,String.class).invoke(resumeInfo,JsonUtil.toJsonString(listmodel));
            resumeRepository.save(resumeInfo);
        } catch (NoSuchMethodException | SecurityException | IllegalAccessException | IllegalArgumentException | InvocationTargetException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }
    /**
     * @Description 通过反射和泛型对类型为Json的字段值进行相应的插入或更新
     * @Date 23:31 2018/4/28
     * @Param [resumeInfo 目标操作简历对象, deleteType 需要删除的字段属性名, index 存储在Json中的索引号]
     * @return boolean
     */
    @Override
    @Modifying(clearAutomatically = true)
    @Transactional
    public boolean deleteJsonFiled(ResumeInfo resumeInfo, String deleteType, int index) {
        //首字母转为大写
        deleteType = StringUtil.toUpperCaseInitial(deleteType);
        try {
            //获取resume中对应deleteType属性的原值
            Method method = resumeInfo.getClass().getMethod("get" + deleteType);
            String val = (String) method.invoke(resumeInfo);
            //json转为List
            List listmodel = JsonUtil.jsontoList(val,Class.forName("com.version1.VO."+(deleteType.equals("internship")?"WorkExperience":deleteType)+"VO"));
            //根据index删除json对应记录
            listmodel.remove(index);
            //将List转回json并设回，执行数据库保存操作
            resumeInfo.getClass().getMethod("set"+deleteType,String.class).invoke(resumeInfo,JsonUtil.toJsonString(listmodel));
            resumeRepository.save(resumeInfo);
        } catch (NoSuchMethodException | SecurityException | IllegalAccessException | IllegalArgumentException | InvocationTargetException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }
}
