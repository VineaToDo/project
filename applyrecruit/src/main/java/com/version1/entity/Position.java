package com.version1.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.Set;

/**
 * @ClassName Position
 * @Description 职位实体
 * @Date 2018/4/13 13:53
 * @Version 1.0
 **/
@Entity
@Getter
@Setter
@DynamicUpdate
@DynamicInsert
public class Position implements Serializable {

    @Id
    @GeneratedValue
    private Integer id;
    @Column(length = 64)
    private String name;//职位名称
    @Column(length = 32)
    private String workplace;//工作地点
    @Column(columnDefinition = "enum('全职','兼职','实习','校园')")
    private String property;//工作性质：全职，兼职，实习，校园
    @Column(length = 16)
    private String experience;//工作经验
    @Column(length = 8)
    private Integer recruitNum;//招聘人数
    @Column(columnDefinition = "text")
    private String description;//职位描述
    @Column(length = 128)
    private String Tag;//职位标签
    private byte state = 0;//职位状态，0：创建未发布；1：发布中职位；2：已下线职位；

    private Boolean isLocked = Boolean.FALSE;

    private Integer hit = 0;//点击量
    private Integer sent = 0;//简历投递量
    private Integer collect = 0;//收藏量

    @Column(columnDefinition = "smallint(3) comment '学历编码'")
    private int degree;//学历要求
    @Column(columnDefinition = "smallint(3) comment '月薪编码'")
    private int salary;//职位月薪

    @Transient
    private String degreeStr;
    @Transient
    private String salaryStr;

    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
    @Column(columnDefinition = "timestamp null default CURRENT_TIMESTAMP")
    private Date createdTime;
    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
    @Column(columnDefinition = "timestamp null default CURRENT_TIMESTAMP on update current_timestamp(0)")
    private Date updatedTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
    @Column(columnDefinition = "timestamp null default CURRENT_TIMESTAMP")
    private Date deadline;//截止时间

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "company_id")
    private CompanyInfo companyInfo;

    @JsonIgnore
    @Transient
    private Integer deptId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "department_id")
    private Department department;

    @Transient
    private Integer type;//职位类型
    @ManyToOne(cascade =  {CascadeType.PERSIST,CascadeType.MERGE},fetch = FetchType.EAGER)
    @JoinColumn(name = "typeId")
    private JobType jobType;

    //用户 -- 职位：多对多关系（收藏表）
    @JsonIgnore
    @ManyToMany(cascade = {CascadeType.ALL},mappedBy = "positions")
    private  Set<UserInfo> userInfos;

    @Override
    public int hashCode() {
        return this.getId();
    }

    @Override
    public boolean equals(Object obj) {
        if(!(obj instanceof Position)) return false;

        if(obj == this) return true;

        return this.getId().intValue() == ((Position) obj).getId().intValue();
    }
}
