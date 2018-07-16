package com.version1.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.*;
import java.io.Serializable;

/**
 * @ClassName DictItems
 * @Description TODO
 * @Date 2018/5/13 13:52
 * @Version 1.0
 */
@Entity
@Data
@DynamicInsert
@DynamicUpdate
public class DictItems {
    @Id
    @GeneratedValue
    private Integer id;
    @Column(length = 8)
    private Integer code;
    @Column(nullable = false,length = 16)
    private String value;

    @Transient
    private Integer pid;

    @JsonIgnore
    @ManyToOne(cascade = {CascadeType.PERSIST,CascadeType.MERGE,CascadeType.REFRESH})
    @JoinColumn(name = "dictId")
    private Dict dict;
}
