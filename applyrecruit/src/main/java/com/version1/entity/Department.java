package com.version1.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * @ClassName Department
 * @Description 部门实体
 * @Date 2018/4/12 22:44
 * @Version 1.0
 **/
@Entity
@Data
@DynamicUpdate
@DynamicInsert
public class Department {

    @Id
    @GeneratedValue
    private Integer id;
    @Column(length = 64)
    private String name;

    @Column(columnDefinition = "timestamp null default CURRENT_TIMESTAMP")
    private Date createdTime;
    @Column(columnDefinition = "timestamp null default CURRENT_TIMESTAMP on update current_timestamp(0)")
    private Date updatedTime;

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "company_id")
    private CompanyInfo companyInfo;

    //部门 -- 职位：一对多关系
    @JsonIgnore
    @OneToMany(cascade = {CascadeType.ALL})
    @JoinColumn(name = "department_id")
    private List<Position> positions;

}
