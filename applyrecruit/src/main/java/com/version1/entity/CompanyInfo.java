package com.version1.entity;


import lombok.Data;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * @ClassName CompanyInfo
 * @Description 公司实体
 * @Date 2018/4/12 20:51
 * @Version 1.0
 */
@Entity
@Data
@DynamicUpdate
@DynamicInsert
public class CompanyInfo {

    @Id
    @GeneratedValue
    private Integer id;
    @Column(length = 64)
    private String name;//公司名称
    @Column(length = 128)
    private String address;//公司地址
    @Column(columnDefinition = "enum('国有企业','集体企业','联营企业','股份合作制企业','私营企业','个体户','合伙企业','有限责任公司','股份有限公司')")
    private String property;//公司性质
    @Column(length = 64)
    private String trade;//公司行业
    @Column(length = 16)
    private String dimensions;//公司规模
    @Column(columnDefinition = "text")
    private String introduction;//简介
    private String brandIcon;//商标

    @Column(columnDefinition = "timestamp null default CURRENT_TIMESTAMP")
    private Date createdTime;
    @Column(columnDefinition = "timestamp null default CURRENT_TIMESTAMP on update current_timestamp(0)")
    private Date updatedTime;

    //公司 -- 企业用户：一对一关系
//    @OneToOne(cascade = {CascadeType.ALL}, fetch = FetchType.LAZY)
//    @JoinColumn(name = "user_id")
//    private UserInfo userInfo;

    //公司 -- 部门：一对多关系
    @OneToMany(cascade = {CascadeType.ALL},fetch = FetchType.EAGER)
    @JoinColumn(name = "company_id")
    private List<Department> departments;

    //公司 -- 职位：一对多关系
    @OneToMany(cascade = {CascadeType.ALL})
    @JoinColumn(name = "company_id")
    private List<Position> positions;

}
