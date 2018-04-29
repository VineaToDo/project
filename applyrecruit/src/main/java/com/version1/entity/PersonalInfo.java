package com.version1.entity;

import lombok.Data;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
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
    @Column(columnDefinition = "date null")
    private Date birthday;
    @Column(columnDefinition = "date null comment '工作年份'")
    private Date workYear;
    @Column(length = 16)
    private String address;
    @Column(length = 12)
    private String phone;
    @Column(length = 32)
    private String email;
    @Column(columnDefinition = "tinyint(1) comment '婚姻状况:未婚,已婚,离异,保密'")
    private byte marital;
    @Column(columnDefinition = "tinyint(1) comment '政治面貌:中共党员(含预备党员),团员,群众,民主党派,其他'")
    private byte politics;

    @Column(columnDefinition = "timestamp null default CURRENT_TIMESTAMP")
    private Date createdTime;
    @Column(columnDefinition = "timestamp null default CURRENT_TIMESTAMP on update current_timestamp(0)")
    private Date updatedTime;

}
