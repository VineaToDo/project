package com.version1.entity;

import lombok.Data;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.*;
import java.util.Date;

/**
 * @ClassName JobIntension
 * @Description TODO
 * @Date 2018/4/22 18:03
 * @Version 1.0
 */
@Entity
@Data
@DynamicUpdate
@DynamicInsert
public class JobIntension {

    @Id
    @GeneratedValue
    private Integer id;
    @Column(columnDefinition = "enum('全职','兼职','实习') comment '工作性质'")
    private String property;
    @Column(columnDefinition = "varchar(16) comment '工作地点'")
    private String workCity;//
    @Column(columnDefinition = "varchar(32) comment '行业'")
    private String profession;
    @Column(columnDefinition = "varchar(32) comment '职业'")
    private String career;
    @Column(columnDefinition = "varchar(16) comment '月薪'")
    private String salary;
    @Column(columnDefinition = "varchar(8) comment '工作经验'")
    private String experience;

    @Column(columnDefinition = "timestamp null default CURRENT_TIMESTAMP")
    private Date createdTime;
    @Column(columnDefinition = "timestamp null default CURRENT_TIMESTAMP on update current_timestamp(0)")
    private Date updatedTime;

}
