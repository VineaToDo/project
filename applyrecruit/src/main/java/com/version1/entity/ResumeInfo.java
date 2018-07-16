package com.version1.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.Set;

/**
 * @ClassName ResumeVO
 * @Description TODO
 * @Date 2018/4/13 15:26
 * @Version 1.0
 */
@Entity
@Getter
@Setter
@DynamicUpdate
@DynamicInsert
public class ResumeInfo implements Serializable {
    @Id
    @GeneratedValue
    private Integer id;
    @Column(columnDefinition = "json null comment '教育背景'")
    private String education;
    @Column(columnDefinition = "json null comment '工作经历'")
    private String workExperience;
    @Column(columnDefinition = "json null comment '实习经历'")
    private String internship;
    @Column(columnDefinition = "json null comment '培训经历'")
    private String training;
    @Column(columnDefinition = "json null comment '项目经历'")
    private String project;
    @Column(columnDefinition = "json null comment '语言能力'")
    private String language;
    @Column(columnDefinition = "json null comment '证书'")
    private String credential;
    @Column(columnDefinition = "json null comment '专业技能'")
    private String skill;
    @Column(columnDefinition = "json null comment '校内情况'")
    private String school;
    @Column(columnDefinition = "json null comment '其他信息'")
    private String others;

    @JsonFormat(pattern = "yyyy-MM-dd")
    @Column(columnDefinition = "timestamp null default CURRENT_TIMESTAMP")
    private Date createdTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Column(columnDefinition = "timestamp null default CURRENT_TIMESTAMP on update current_timestamp(0)")
    private Date updatedTime;

    //简历总表 -- 个人信息表：单向一对一关系
    @OneToOne(cascade = {CascadeType.ALL},fetch = FetchType.EAGER)
    @JoinColumn(name = "perinfo_id")
    private PersonalInfo personalInfo;

    /*简历 -- 职位：多对多关系（投递表）
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name = "deliver",joinColumns = {@JoinColumn(name = "resumeId")},inverseJoinColumns = {@JoinColumn(name = "positionId")})
    private Set<Position> positions;
    */

}
