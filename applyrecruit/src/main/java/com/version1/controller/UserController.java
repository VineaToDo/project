package com.version1.controller;

import com.version1.VO.ResultVO;
import com.version1.commons.vcode.Captcha;
import com.version1.commons.vcode.GifCaptcha;
import com.version1.entity.Deliver;
import com.version1.entity.SysRole;
import com.version1.entity.UserInfo;
import com.version1.service.DeliverService;
import com.version1.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user")
@Slf4j
public class UserController extends BaseController {

    @Autowired
    private UserService userService;

    @Autowired
    private DeliverService deliverService;

    @GetMapping("/getLogin")
    public String getLogin(){
        return "login";
    }
    @GetMapping("/getRegister")
    public String getRegister(){
        return "register_per";
    }
//    @GetMapping("/admin")
//    public String adminlogin(){
//        return "/admin/index";
//    }
    @GetMapping("/recruit")
    public String recruit(){
        List<Deliver> delivers = deliverService.findNewestDeliver(getLoginUser().getCompanyInfo());

        getModelMap().addAttribute("newest",delivers);
        return "/enterprise/index";
    }

    @GetMapping("/error")
    public String error(){
        return "error";
    }

    @GetMapping("/getGifCode")
    public void getGifCode(HttpServletResponse response, HttpServletRequest request){
        try {
            response.setHeader("Pragma", "No-cache");
            response.setHeader("Cache-Control", "no-cache");
            response.setDateHeader("Expires", 0);
            response.setContentType("image/gif");
            /**
             * gif格式动画验证码
             * 宽，高，位数。
             */
            Captcha captcha = new GifCaptcha(140,33,4);
            //输出
            captcha.out(response.getOutputStream());
            HttpSession session = request.getSession(true);
            //存入Session
            session.setAttribute("_code",captcha.text().toLowerCase());
        } catch (Exception e) {
            System.err.println("获取验证码异常："+e.getMessage());
        }
    }

    @ResponseBody
    @PostMapping("/login")
    public ResultVO userSignIn(String userName,String password,String vCode,Boolean rememberMe){
//        if(vcode==null||vcode==""){
//            resultMap.put("status", 500);
//            resultMap.put("message", "验证码不能为空！");
//            return resultMap;
//        }
        Subject subject = SecurityUtils.getSubject();
        Session session = subject.getSession();
        //转化成小写字母
        vCode = vCode.toLowerCase();
        String v = (String) session.getAttribute("_code");
        //还可以读取一次后把验证码清空，这样每次登录都必须获取验证码
        session.removeAttribute("_code");
        if(!vCode.equals(v)){
            return new ResultVO(400,"验证码错误！");
        }

        UsernamePasswordToken token = new UsernamePasswordToken(userName,password,rememberMe);
        try {
            subject.login(token);
        } catch (LockedAccountException e){
            log.info(e.getMessage());
            return new ResultVO(401,"用户已锁定！");
        } catch(UnknownAccountException e) {
            log.info(e.getMessage());
            return new ResultVO(404,"用户名不存在！");
        }catch (AuthenticationException e){
            log.info(e.getMessage());
//            return new ResultVO(500,"服务器正忙，请稍后再试...");
            return new ResultVO(500,"用户名或密码错误！");
        }
        UserInfo userInfo = userService.findByUsername((String) subject.getPrincipal());
        getSession().setAttribute("user",userInfo);
        log.info("登录成功");
        SysRole role = userInfo.getRole();
        if(role.getRole().equals("recruit")) return new ResultVO<String>(200,"登录成功！","/user/recruit");
        else if(role.getRole().equals("apply")) return new ResultVO<String>(200,"登录成功！","/index/");
        else return new ResultVO<String>(200,"登录成功！","/admin/relayUrl/index");
    }

    @GetMapping("/logout")
    public String userLogout(){
        Subject subject = SecurityUtils.getSubject();
        subject.logout();
        log.info("注销成功");
        return "/index/";
    }

    @ResponseBody
    @RequestMapping("/register")
    public ResultVO register(UserInfo userInfo){
        boolean res = userService.register(userInfo);
        if(res) return new ResultVO(200,"注册成功");
        else return new ResultVO(500,"服务器繁忙，请稍后再试！");
    }

    @ResponseBody
    @RequestMapping("/checkUsername")
    public Map checkUsername(String userName){
        boolean result = true;
        UserInfo user = userService.findByUsername(userName);
        if(user != null) result = false;
        Map map = new HashMap();
        map.put("valid",result);
        return map;
    }

    @ResponseBody
    @RequestMapping("/saveInfo")
    public ResultVO saveInfo(UserInfo userInfo){
        UserInfo user = getLoginUser();
        boolean res = userService.updateUser(userInfo,user);
        if (res){
            return new ResultVO(200,"保存成功");
        }
        return new ResultVO(500,"保存失败");
    }

    @ResponseBody
    @RequestMapping("/checkPassword")
    public Map checkPassword(String passwordOld){
        UserInfo user = getLoginUser();
        boolean result = false;
        if(user.getPassword().equals(passwordOld)) result = true;
        Map map = new HashMap();
        map.put("valid",result);
        return map;
    }

    @ResponseBody
    @RequestMapping("/updatePassword")
    public ResultVO updatePassword(String password){
        UserInfo user = getLoginUser();
        boolean res = userService.updatePassword(password,user);
        if (res){
            return new ResultVO(200,"修改成功");
        }
        return new ResultVO(500,"修改失败");
    }

}