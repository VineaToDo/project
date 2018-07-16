package com.version1.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.*;
import java.util.Date;

/**
 * @ClassName Complaint
 * @Description TODO
 * @Date 2018/5/29 19:43
 * @Version 1.0
 */
@Entity
@Getter
@Setter
@DynamicUpdate
@DynamicInsert
public class Complaint {

    @Id
    @GeneratedValue
    private Integer id;


    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
    @Column(columnDefinition = "timestamp null default CURRENT_TIMESTAMP")
    private Date createdTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
    @Column(columnDefinition = "timestamp null default CURRENT_TIMESTAMP on update current_timestamp(0)")
    private Date updatedTime;

    @Column(length = 16)
    private String informer;
    @Column(length = 16)
    private String contactPhone;
    @Column(length = 64)
    private String reason;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "positionId")
    private Position position;
}
