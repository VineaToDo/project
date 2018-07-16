package com.version1.controller;

import com.version1.entity.DictItems;
import com.version1.entity.UserInfo;
import com.version1.repository.DeliverRepository;
import com.version1.repository.DictRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName BaseController
 * @Description TODO
 * @Date 2018/4/27 18:38
 * @Version 1.0
 */
@Slf4j
public class BaseController {

    private static final ThreadLocal<HttpServletRequest> requestContainer = new ThreadLocal<HttpServletRequest>();

    private static final ThreadLocal<HttpServletResponse> responseContainer = new ThreadLocal<HttpServletResponse>();

    private static final ThreadLocal<HttpSession> sessionContainer = new ThreadLocal<HttpSession>();

    private static final ThreadLocal<ModelMap> modelContainer = new ThreadLocal<ModelMap>();

    @Autowired
    private DictRepository dictRepository;

    @Autowired
    private DeliverRepository deliverRepository;

    /**
     * 初始化response
     * @param response
     */
    @ModelAttribute
    private final void initResponse(HttpServletResponse response) {
        responseContainer.set(response);
    }

    /**
     * 获取当前线程的response对象
     * @return
     */
    protected final HttpServletResponse getResponse() {
        return responseContainer.get();
    }

    /**
     * 初始化request
     * @param request
     */
    @ModelAttribute
    private final void initRequest(HttpServletRequest request) {
        requestContainer.set(request);
    }

    /**
     * 获取当前线程的request对象
     * @return
     */
    protected final HttpServletRequest getRequest() {
        return requestContainer.get();
    }

    /**
     * 初始化session
     * @param session
     */
    @ModelAttribute
    private final void initSession(HttpSession session){
        sessionContainer.set(session);
    }

    /**
     * 获取当前线程的Session对象
     * @return
     */
    protected final HttpSession getSession() {
        return sessionContainer.get();
    }

    /**
     * 设置model
     * @param model
     */
    @ModelAttribute
    private final void initModelMap(ModelMap model) {
        modelContainer.set(model);
    }

    /**
     * 获取当前线程的modelMap对象
     * @return
     */
    protected final ModelMap getModelMap() {
        return modelContainer.get();
    }

    /**
     * @Description 获取当前已登录用户
     * @Date 23:37 2018/4/28
     * @Param []
     * @return com.version1.entity.UserInfo
     */
    protected final UserInfo getLoginUser(){
        return (UserInfo) getSession().getAttribute("user");
    }

    /**
     * @Description 初始化数据字典
     * @Date 21:16 2018/6/20
     * @Param [session]
     * @return void
     */
    @ModelAttribute
    private final void initDict(HttpSession session){
        if(getSession().getAttribute("propertyDict")==null){
            List<DictItems> propertyDict = dictRepository.findByCode("property").getDict_items();
            Map<Integer,DictItems> propertyMap = new HashMap<>();
            for (DictItems dictItems:propertyDict){
                propertyMap.put(dictItems.getCode(),dictItems);
            }
            session.setAttribute("propertyDict",propertyMap);
        }
        if(getSession().getAttribute("dimensionsDict")==null){
            List<DictItems> dimensionsDict = dictRepository.findByCode("dimensions").getDict_items();
            Map<Integer,DictItems> dimensionsMap = new HashMap<>();
            for (DictItems dictItems:dimensionsDict){
                dimensionsMap.put(dictItems.getCode(),dictItems);
            }
            session.setAttribute("dimensionsDict",dimensionsMap);
        }
        if(getSession().getAttribute("eduDegreeDict")==null){
            List<DictItems> edudegreeDict = dictRepository.findByCode("edudegree").getDict_items();
            Map<Integer,DictItems> edudegreeMap = new HashMap<>();
            for (DictItems dictItems:edudegreeDict){
                edudegreeMap.put(dictItems.getCode(),dictItems);
            }
            session.setAttribute("eduDegreeDict",edudegreeMap);
        }
        if(getSession().getAttribute("politicsDict")==null){
            List<DictItems> politicsDict = dictRepository.findByCode("politics").getDict_items();
            Map<Integer,DictItems> politicsMap = new HashMap<>();
            for (DictItems dictItems:politicsDict){
                politicsMap.put(dictItems.getCode(),dictItems);
            }
            session.setAttribute("politicsDict",politicsMap);
        }
        if(getSession().getAttribute("maritalDict")==null){
            List<DictItems> maritalDict = dictRepository.findByCode("marital").getDict_items();
            Map<Integer,DictItems> maritalMap = new HashMap<>();
            for (DictItems dictItems:maritalDict){
                maritalMap.put(dictItems.getCode(),dictItems);
            }
            session.setAttribute("maritalDict",maritalMap);
        }
        if(getSession().getAttribute("salaryDict")==null){
            List<DictItems> salaryDict = dictRepository.findByCode("salary").getDict_items();
            Map<Integer,DictItems> salaryMap = new HashMap<>();
            for (DictItems dictItems:salaryDict){
                salaryMap.put(dictItems.getCode(),dictItems);
            }
            session.setAttribute("salaryDict",salaryMap);
        }
        if(getSession().getAttribute("languageDict")==null){
            List<DictItems> languageDict = dictRepository.findByCode("language").getDict_items();
            Map<Integer,DictItems> languageMap = new HashMap<>();
            for (DictItems dictItems:languageDict){
                languageMap.put(dictItems.getCode(),dictItems);
            }
            session.setAttribute("languageDict",languageMap);
        }
    }
    /**
     * @Description 监听投递反馈消息
     * @Date 21:16 2018/6/20
     * @Param []
     * @return void
     */
    @ModelAttribute
    private final void monitorMessage(){
        UserInfo user = null;
        if(getSession() != null)
            user = (UserInfo) getSession().getAttribute("user");
        if(user != null && user.getRole().getRole().equals("apply")){
            int count = (int) deliverRepository.countByKnownFalseAndResumeInfo(user.getResumeInfo());
            getModelMap().addAttribute("count",count);
        }
    }
    /**
     * @Description 检测企业用户角色功能权限
     * @Date 21:17 2018/6/20
     * @Param []
     * @return boolean
     */
    protected boolean interceptAvailable(){
        if(getLoginUser().getCompanyInfo() == null || getLoginUser().getCompanyInfo().getDepartments() == null || getLoginUser().getCompanyInfo().getDepartments().size() == 0){
            getModelMap().addAttribute("resultMsg","请先完善公司信息和部门结构");
            getModelMap().addAttribute("flag",1);
            return true;
        }
        if(!getLoginUser().getCompanyInfo().getAvailable()){
            getModelMap().addAttribute("resultMsg", "暂无权限，请等待管理员审核");
            getModelMap().addAttribute("flag",2);
            return true;
        }
        return false;
    }
}
