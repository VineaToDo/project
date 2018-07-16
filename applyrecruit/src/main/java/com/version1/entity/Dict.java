package com.version1.entity;

import lombok.Data;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.*;
import java.util.List;

/**
 * @ClassName Dict
 * @Description TODO
 * @Date 2018/5/13 13:15
 * @Version 1.0
 */
@Entity
@Data
@DynamicInsert
@DynamicUpdate
public class Dict {

    @Id
    @GeneratedValue
    private Integer id;
    @Column(unique = true,nullable = false,length = 16)
    private String code;
    @Column(length = 16)
    private String name;
    @Column(length = 64)
    private String description;
    @OneToMany(cascade = {CascadeType.PERSIST,CascadeType.MERGE,CascadeType.REMOVE,CascadeType.REFRESH},mappedBy = "dict",fetch = FetchType.EAGER)
    private List<DictItems> dict_items;

}
