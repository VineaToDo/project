package com.version1.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * @ClassName JobTypeRepository
 * @Description TODO
 * @Date 2018/5/9 16:57
 * @Version 1.0
 */
@Entity
@Data
@DynamicInsert
@DynamicUpdate
public class JobType {

    @Id
    @GeneratedValue
    private Integer id;

    @Column(length = 16)
    private String name;

    private Integer jobCount;//职位数
    private Integer hit;//点击数

    @JsonIgnore
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "parentId")
    private JobType parent;

    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL,mappedBy = "parent")
    private List<JobType> childrens;

    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL,mappedBy = "jobType")
    private List<Position> positions;

    @JsonFormat(pattern = "yyyy-MM-dd hh:mm:ss")
    @Column(columnDefinition = "timestamp null default CURRENT_TIMESTAMP")
    private Date createdTime;
    @JsonFormat(pattern = "yyyy-MM-dd hh:mm:ss")
    @Column(columnDefinition = "timestamp null default CURRENT_TIMESTAMP on update current_timestamp(0)")
    private Date updatedTime;

    @Transient
    private Integer pid;


}
