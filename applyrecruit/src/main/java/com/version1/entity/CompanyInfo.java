package com.version1.entity;


import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * @ClassName CompanyInfo
 * @Description 公司实体
 * @Date 2018/4/12 20:51
 * @Version 1.0
 */
@Entity
@Getter
@Setter
@DynamicUpdate
@DynamicInsert
public class CompanyInfo implements Serializable {

    @Id
    @GeneratedValue
    private Integer id;
    @Column(length = 64)
    private String name;//公司名称
    @Column(length = 128)
    private String address;//公司地址
    @Column(length = 64)
    private String trade;//公司行业
    @Column(columnDefinition = "text")
    private String introduction;//简介
    private String brandIcon;//商标

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Column(columnDefinition = "timestamp null default CURRENT_TIMESTAMP")
    private Date createdTime;
    @Column(columnDefinition = "timestamp null default CURRENT_TIMESTAMP on update current_timestamp(0)")
    private Date updatedTime;

    private Boolean available = Boolean.FALSE;//公司角色功能权限是否开放

    //公司 -- 企业用户：一对一关系
    @JsonIgnore
    @OneToOne(cascade = {CascadeType.MERGE,CascadeType.PERSIST}, mappedBy = "companyInfo")
    private UserInfo userInfo;

    private Integer propertyCode;//公司性质编码

    private Integer dimensionsCode;//公司规模编码

    @Transient
    private String property;//公司性质

    @Transient
    private String dimensions;//公司规模

    //公司 -- 部门：一对多关系
    @JsonIgnore
    @OneToMany(cascade = {CascadeType.PERSIST,CascadeType.REFRESH},fetch = FetchType.EAGER)
    @JoinColumn(name = "company_id")
    private List<Department> departments;

    //公司 -- 职位：一对多关系
    @JsonIgnore
    @OneToMany(cascade = {CascadeType.REFRESH,CascadeType.PERSIST})
    @JoinColumn(name = "company_id")
    private List<Position> positions;

}
