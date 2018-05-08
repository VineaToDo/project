package com.version1.controller;

import com.version1.VO.ResultVO;
import com.version1.entity.SysRole;
import com.version1.entity.UserInfo;
import com.version1.repository.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user")
@Slf4j
public class UserController extends BaseController {

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/getUser")
    public ResultVO user(){
        ResultVO resultVO = new ResultVO();
        return resultVO;
    }
    @RequestMapping("/welcome")
    public String welcome(){
        getModelMap().put("user",userRepository.findOne(1));
        return "resume_view";
    }
    @GetMapping("/recruit")
    public String recruit(){
        HttpSession session = getRequest().getSession();
        if(session.getAttribute("user") == null) {
            try {
                UserInfo userInfo = userRepository.findByUserName("hr");
                session.setAttribute("user", userInfo);
            } catch (Exception e) {
                log.info("登录失败!");
                e.printStackTrace();
            }
        }
        log.info("登录成功");

        return "/enterprise/index";
    }

    @GetMapping("/error")
    public String error(){
        return "error";
    }


    @PostMapping("/login")
    public String userSignIn(String userName,String password){
        UserInfo userInfo = null;
        try {
            userInfo = userRepository.findByUserName(userName);
            getRequest().getSession().setAttribute("user",userInfo);
        } catch (Exception e) {
            log.info("登录失败");
            e.printStackTrace();
            return "error";
        }
        log.info("登录成功");

        List<SysRole> roleList = userInfo.getRoleList();
        for (SysRole role: roleList){
            if(role.getRole().equals("recruit")){
                return "/enterprise/index";
            }
        }

        return "index";
    }

    @GetMapping("/logout")
    public String userLogout(){
        getRequest().getSession().removeAttribute("user");
        log.info("注销成功");
        return "index";
    }


}