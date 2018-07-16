package com.version1.VO;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * @ClassName ProjectVO
 * @Description TODO
 * @Date 2018/5/3 14:29
 * @Version 1.0
 */
@Data
public class ProjectVO implements IdGetter {

    @JSONField(serialize = false)
    private Integer id;

    private String name;
    private String dimensions;
    @DateTimeFormat(pattern = "yyyy-MM")
    @JSONField(format="yyyy-MM")
    private Date beginDate;
    @DateTimeFormat(pattern = "yyyy-MM")
    @JSONField(format="yyyy-MM")
    private Date endDate;
    private String duty;
    private String description;

}
