package com.version1.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * @ClassName PersonalInfo
 * @Description TODO
 * @Date 2018/4/22 18:01
 * @Version 1.0
 */
@Entity
@Data
@DynamicUpdate
@DynamicInsert
public class PersonalInfo implements Serializable {
    @Id
    @GeneratedValue
    private Integer id;
    @Column(length = 64)
    private String name;
    @Column(length = 1)
    private byte gender;
    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(columnDefinition = "date null")
    private Date birthday;
    @JsonFormat(pattern = "yyyy-MM",timezone = "GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM")
    @Column(columnDefinition = "date null comment '工作年份'")
    private Date workYear;
    @Column(length = 16)
    private String address;
    @Column(length = 12)
    private String phone;
    @Column(length = 32)
    private String email;
    @Column(columnDefinition = "smallint(3) comment '婚姻状况:未婚,已婚,离异,保密'")
    private int marital;
    @Column(columnDefinition = "smallint(3) comment '政治面貌:中共党员(含预备党员),团员,群众,民主党派,其他'")
    private int politics;

    @Transient
    private String maritalValue;
    @Transient
    private String politicsValue;

    @Column(columnDefinition = "timestamp null default CURRENT_TIMESTAMP")
    private Date createdTime;
    @Column(columnDefinition = "timestamp null default CURRENT_TIMESTAMP on update current_timestamp(0)")
    private Date updatedTime;

}
