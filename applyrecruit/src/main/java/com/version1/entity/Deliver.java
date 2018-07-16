package com.version1.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.RequestParam;

import javax.persistence.*;
import java.util.Date;

/**
 * @ClassName Deliver
 * @Description TODO
 * @Date 2018/5/15 20:59
 * @Version 1.0
 */
@Entity
@Getter
@Setter
@DynamicInsert
@DynamicUpdate
public class Deliver {

    @Id
    @GeneratedValue
    private Integer id;

    private Boolean isCollected = Boolean.FALSE;//收藏投递简历

    @Column(length = 1)
    private byte available = 0;//投递状态：0-已投递，HR未查看；1-HR已查看；2-已发面试通知；3-待沟通；4-已拒绝

    private Boolean informed = Boolean.FALSE;//是否被投诉
    private Boolean known = Boolean.TRUE;//求职者是否已查看反馈

    @Column(length = 64)
    private String interviewAddr;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Column(columnDefinition = "timestamp null")
    private Date interviewTime;
    @Column(length = 16)
    private String contactName;
    @Column(length = 12)
    private String contactPhone;

    @Column(length = 128)
    private String reason;


    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Column(columnDefinition = "timestamp null default CURRENT_TIMESTAMP")
    private Date createdTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Column(columnDefinition = "timestamp null default CURRENT_TIMESTAMP on update current_timestamp(0)")
    private Date updatedTime;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "resumeId")
    private ResumeInfo resumeInfo;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "positionId")
    private Position position;



}
