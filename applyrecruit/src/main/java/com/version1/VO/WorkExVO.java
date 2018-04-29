package com.version1.VO;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;

import java.util.Date;

/**
 * @ClassName WorkExVO
 * @Description TODO
 * @Date 2018/4/27 17:30
 * @Version 1.0
 */
@Data
public class WorkExVO {

    @JSONField(serialize = false)
    private Integer id;
    private String companyName;
    private String property;//公司性质
    private String dimensions;//公司规模

    //工作开始和结束时间
    @JSONField(format="yyyy-MM")
    private Date beginDate;
    @JSONField(format="yyyy-MM")
    private Date endDate;

    private String position;//职位名称
    private String trade;//公司所属行业
    private String type;//职位类别
    private String salary;//税前月薪
    private String description;//工作描述



}
