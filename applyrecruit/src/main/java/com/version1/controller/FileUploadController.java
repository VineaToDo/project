package com.version1.controller;

import com.version1.VO.ResultVO;
import com.version1.commons.exceptions.ImageAcceptNotSupportException;
import com.version1.commons.exceptions.ImageMaxSizeOverFlow;
import com.version1.commons.utils.HttpUtil;
import com.version1.commons.utils.UploadUtil;
import com.version1.entity.UserInfo;
import com.version1.service.CompanyService;
import com.version1.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;

/**
 * @ClassName FileUploadController
 * @Description TODO
 * @Date 2018/5/31 16:33
 * @Version 1.0
 */
@Controller
@RequestMapping("/file")
@Slf4j
public class FileUploadController {

    @Autowired
    private UserService userService;


    @ResponseBody
    @PostMapping("/uploadImage")
    public ResultVO uploadImage(@RequestParam("file") MultipartFile file, HttpServletRequest request) {
        UserInfo userInfo = (UserInfo) request.getSession().getAttribute("user");
        String imagePath;
        try{
            imagePath = userService.uploadImage(userInfo,file);
        }catch (ImageAcceptNotSupportException ex) {
            return new ResultVO(415,"不支持的图片类型");
        }catch (ImageMaxSizeOverFlow ex) {
            return new ResultVO(429,"请上传小于2M的图片");
        }
        System.out.println(" basePath   ===  "+HttpUtil.serverBasePath(request));
        String msg = HttpUtil.serverBasePath(request) + imagePath;
        return new ResultVO(200,msg);
    }

}
