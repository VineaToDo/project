package com.version1.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.*;
import java.util.Date;
import java.util.List;
import java.util.Set;

/**
 * @ClassName SysRole
 * @Description 帐户信息实体
 * @Date 2018/4/11 19:38
 * @Version 1.0
 */

@Entity
@Data
@DynamicUpdate
@DynamicInsert
public class UserInfo {

    @Id
    @GeneratedValue
    private Integer id;
    @Column(unique =true,length = 128)
    private String userName;//帐号
    @Column(length = 64)
    private String name;//名称（昵称或者真实姓名，不同系统不同定义）
    @Column(length = 128)
    private String password; //密码;
    private String salt;//加密密码的盐
    private Boolean isLocked = Boolean.FALSE;//用户状态— FALSE:正常状态,TRUE：用户被锁定.

    @Column(length = 32)
    private String email;
    @Column(length = 12)
    private String phone;

    @JsonFormat(pattern = "yyyy-MM-dd hh:mm:ss")
    @Column(columnDefinition = "timestamp null default CURRENT_TIMESTAMP")
    private Date createdTime;
    @JsonFormat(pattern = "yyyy-MM-dd hh:mm:ss")
    @Column(columnDefinition = "timestamp null default CURRENT_TIMESTAMP on update current_timestamp(0)")
    private Date updatedTime;

    @JsonIgnore
    @ManyToOne(fetch= FetchType.EAGER)//立即从数据库中进行加载数据;
    @JoinColumn(name = "roleId")
    private SysRole role;// 一个用户具有一个角色

    @JsonIgnore
    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "companyId")
    private CompanyInfo companyInfo;

    @JsonIgnore
    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "resumeId")
    private ResumeInfo resumeInfo;


    //用户 -- 职位：多对多关系（收藏表）
    @JsonIgnore
    @ManyToMany
    @JoinTable(name = "collection",joinColumns = {@JoinColumn(name = "uid")},inverseJoinColumns = {@JoinColumn(name = "positionId")})
    private Set<Position> positions;



}