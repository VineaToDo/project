package com.version1.service.impl;

import com.version1.VO.QueryUserVO;
import com.version1.VO.ResultVO;
import com.version1.commons.exceptions.ImageAcceptNotSupportException;
import com.version1.commons.exceptions.ImageMaxSizeOverFlow;
import com.version1.commons.utils.HttpUtil;
import com.version1.commons.utils.UploadUtil;
import com.version1.entity.Position;
import com.version1.entity.SysRole;
import com.version1.entity.UserInfo;
import com.version1.repository.CompanyRepository;
import com.version1.repository.PositionRepository;
import com.version1.repository.RoleRepository;
import com.version1.repository.UserRepository;
import com.version1.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

/**
 * @ClassName UserServiceImpl
 * @Description TODO
 * @Date 2018/5/16 11:37
 * @Version 1.0
 */
@Service(value = "userService")
@Transactional(readOnly = true)
@Slf4j
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private PositionRepository positionRepository;

    @Override
    @Modifying(clearAutomatically = true)
    @Transactional
    public boolean register(UserInfo user) {
        try {
            SysRole role = roleRepository.findOne(user.getRoleId());
            user.setRole(role);
            userRepository.saveAndFlush(user);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }

    @Override
    @Modifying(clearAutomatically = true)
    @Transactional
    public boolean updateUser(UserInfo userInfo, UserInfo user) {
        user.setName(userInfo.getName());
        user.setPhone(userInfo.getPhone());
        user.setEmail(userInfo.getEmail());
        try {
            userRepository.saveAndFlush(user);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    @Override
    @Modifying(clearAutomatically = true)
    @Transactional
    public boolean updatePassword(String password, UserInfo user) {
        user.setPassword(password);
        try {
            userRepository.saveAndFlush(user);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    @Override
    public UserInfo findByUsername(String username) {
        UserInfo userInfo = null;
        try {
            userInfo = userRepository.findByUserName(username);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return userInfo;
    }

    @Override
    public Page<UserInfo> findUserList(QueryUserVO queryUserVO) {
        Page<UserInfo> userInfoPage = userRepository.findAll(new Specification<UserInfo>() {
            @Override
            public Predicate toPredicate(Root<UserInfo> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {

                List<Predicate> predicates = new ArrayList<Predicate>();

                if(null != queryUserVO.getRoleName()) predicates.add(criteriaBuilder.equal(root.get("role").get("role"),queryUserVO.getRoleName()));

                if(null != queryUserVO.getResumeId()) predicates.add(criteriaBuilder.equal(root.get("resumeInfo").get("id"),queryUserVO.getResumeId()));

                if(null != queryUserVO.getAvailable()) predicates.add(criteriaBuilder.equal(root.get("companyInfo").get("available"),queryUserVO.getAvailable()));

                return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
            }
        }, new PageRequest(queryUserVO.getPageNumber()-1,queryUserVO.getPageSize(),"desc".equals(queryUserVO.getSortOrder())?Sort.Direction.DESC:Sort.Direction.ASC,queryUserVO.getSortName()));

        return userInfoPage;
    }

    @Override
    @Modifying(clearAutomatically = true)
    @Transactional
    public String uploadImage(UserInfo userInfo, MultipartFile file) throws ImageMaxSizeOverFlow, ImageAcceptNotSupportException {
        String imagePath,dictType;
        if(userInfo.getRole().getRole().equals("apply")){
            dictType = "perHead";
        }else {
            dictType = "companyBrand";
        }
//        try{
        imagePath = UploadUtil.uploadImage(file,dictType);
        System.out.println("imagePath"+ imagePath);

        if (dictType.equals("perHead")){
            userInfo.setHead(imagePath);
        }else {
            userInfo.getCompanyInfo().setBrandIcon(imagePath);
        }
        userRepository.saveAndFlush(userInfo);
//        }catch (ImageAcceptNotSupportException ex) {
//            return new ResultVO(415,"不支持的图片类型");
//        }catch (ImageMaxSizeOverFlow ex) {
//            return new ResultVO(429,"请上传小于2M的图片");
//        }
//        System.out.println(" basePath   ===  "+HttpUtil.serverBasePath(request));
//        String msg = HttpUtil.serverBasePath(request) + imagePath;
        return imagePath;
    }

    @Override
    @Modifying(clearAutomatically = true)
    @Transactional
    public boolean collectPosition(UserInfo userInfo, int positionId) {
        UserInfo userInfoNew = userRepository.findOne(userInfo.getId());
        Position position = positionRepository.findOne(positionId);
        Set<Position> positions = userInfoNew.getPositions();
        if(positions.contains(position)){
            userInfoNew.getPositions().remove(position);
            userInfo.getPositions().remove(position);
            userRepository.saveAndFlush(userInfoNew);
            return false;
        }else {
            userInfoNew.getPositions().add(position);
            userInfo.getPositions().add(position);
            userRepository.saveAndFlush(userInfoNew);
            return true;
        }
    }

    @Override
    @Modifying(clearAutomatically = true)
    @Transactional
    public int lockUser(Integer id) {
        int locked = 0;
        try {
            UserInfo userInfo = userRepository.findOne(id);
            if(userInfo.getIsLocked()){
                locked = 1;
                userInfo.setIsLocked(false);
            }else{
                userInfo.setIsLocked(true);
            }
            userRepository.saveAndFlush(userInfo);
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
        return locked;
    }
}
