package com.version1.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.*;
import java.util.Date;
import java.util.Set;

/**
 * @ClassName Position
 * @Description 职位实体
 * @Date 2018/4/13 13:53
 * @Version 1.0
 **/
@Entity
@Data
@DynamicUpdate
@DynamicInsert
public class Position {

    @Transient
    private Integer deptId;

    @Id
    @GeneratedValue
    private Integer id;
    @Column(length = 64)
    private String name;//职位名称
    @Column(length = 16)
    private String salary;//职位月薪
    @Column(length = 32)
    private String workplace;//工作地点
    @Column(columnDefinition = "enum('全职','兼职','实习','校园')")
    private String property;//工作性质：全职，兼职，实习，校园
    @Column(length = 16)
    private String experience;//工作经验
    @Column(length = 8)
    private Integer recruitNum;//招聘人数
    @Column(length = 32)
    private String type;//职位类型
    @Column(length = 8)
    private String degree;//学历要求
    @Column(columnDefinition = "text")
    private String description;//职位描述
    @Column(length = 128)
    private String Tag;//职位标签
    private byte state;//职位状态，0：创建未发布；1：发布中职位；2：已下线职位

    @Column(columnDefinition = "timestamp null default CURRENT_TIMESTAMP")
    private Date createdTime;
    @Column(columnDefinition = "timestamp null default CURRENT_TIMESTAMP on update current_timestamp(0)")
    private Date updatedTime;

    @JsonIgnore
    @ManyToOne
    @JoinColumn(name = "company_id")
    private CompanyInfo companyInfo;


    @ManyToOne
    @JoinColumn(name = "department_id")
    private Department department;

    //简历 -- 职位：多对多关系（投递表）
    @ManyToMany(mappedBy = "positions")
    private Set<ResumeInfo> resumeInfos;

    //用户 -- 职位：多对多关系（收藏表）
    @ManyToMany(mappedBy = "positions")
    private  Set<UserInfo> userInfos;

}
