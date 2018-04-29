package com.version1.commons.utils;

import com.version1.VO.IdGetter;
import com.version1.entity.ResumeInfo;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

/**
 * @ClassName ReflectFieldUtil
 * @Description TODO
 * @Date 2018/4/28 21:30
 * @Version 1.0
 */
public class ReflectFieldUtil {





    public static <T> String getClassField(Class<T> clazz){



        return "";
    }


    public static <T extends IdGetter> void test(ResumeInfo resumeInfo,String filedName, T t){
        /**
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
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        }catch (SecurityException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }

         if (educationVO.getId() == null) {
         if (resumeInfo.getEducation() == null) {
         educationList = new ArrayList();
         } else {
         educationList = JsonUtil.jsontoList(resumeInfo.getEducation(), EducationVO.class);
         }
         educationList.add(educationVO);
         } else {
         educationList = JsonUtil.jsontoList(resumeInfo.getEducation(), EducationVO.class);
         educationList.set(educationVO.getId(), educationVO);
         }
         resumeInfo.setEducation(JsonUtil.toJsonString(educationList));
         ResumeInfo resumeInfoNew = resumeRepository.save(resumeInfo);


        */
    }


}
