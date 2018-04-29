package com.version1.controller;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @ClassName BaseController
 * @Description TODO
 * @Date 2018/4/27 18:38
 * @Version 1.0
 */

public class BaseController {

    private static final ThreadLocal<HttpServletRequest> requestContainer = new ThreadLocal<HttpServletRequest>();

    private static final ThreadLocal<HttpServletResponse> responseContainer = new ThreadLocal<HttpServletResponse>();

    private static final ThreadLocal<ModelMap> modelContainer = new ThreadLocal<ModelMap>();

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

}
