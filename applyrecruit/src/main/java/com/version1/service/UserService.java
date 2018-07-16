package com.version1.service;

import com.version1.VO.QueryUserVO;
import com.version1.commons.exceptions.ImageAcceptNotSupportException;
import com.version1.commons.exceptions.ImageMaxSizeOverFlow;
import com.version1.entity.UserInfo;
import org.springframework.data.domain.Page;
import org.springframework.web.multipart.MultipartFile;

/**
 * @ClassName UserService
 * @Description TODO
 * @Date 2018/4/28 20:19
 * @Version 1.0
 */
public interface UserService {

    boolean register(UserInfo user);

    boolean updateUser(UserInfo userInfo,UserInfo user);

    boolean updatePassword(String password,UserInfo user);

    UserInfo findByUsername(String username);

    Page<UserInfo> findUserList(QueryUserVO queryUserVO);

    String uploadImage(UserInfo userInfo,MultipartFile file) throws ImageMaxSizeOverFlow, ImageAcceptNotSupportException;

    boolean collectPosition(UserInfo userInfo, int positionId);

    int lockUser(Integer id);

}
