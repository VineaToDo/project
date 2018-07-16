package com.version1.VO;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * @ClassName WorkExperienceVO
 * @Description TODO
 * @Date 2018/4/27 17:30
 * @Version 1.0
 */
@Data
public class WorkExperienceVO implements IdGetter{

    @JSONField(serialize = false)
    private Integer id;
    @JSONField(serialize = false)
    private byte isInternship = 0;
    private String companyName;
    private Integer property;//公司性质
    private Integer dimensions;//公司规模
    private String position;//职位名称
    private String trade;//公司所属行业
    private String type;//职位类别
    private Integer salary;//税前月薪
    private String description;//经历描述
    @JSONField(serialize = false)
    private String propertyValue;
    @JSONField(serialize = false)
    private String dimensionsValue;
    @JSONField(serialize = false)
    private String salaryValue;

    //工作开始和结束时间
    @DateTimeFormat(pattern = "yyyy-MM")
    @JSONField(format="yyyy-MM")
    private Date beginDate;
    @DateTimeFormat(pattern = "yyyy-MM")
    @JSONField(format="yyyy-MM")
    private Date endDate;





}
