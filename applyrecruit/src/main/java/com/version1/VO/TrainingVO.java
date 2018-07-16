package com.version1.VO;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * @ClassName TrainingVO
 * @Description TODO
 * @Date 2018/5/2 19:21
 * @Version 1.0
 */
@Data
public class TrainingVO implements IdGetter {

    @JSONField(serialize = false)
    private Integer id;
    private String name;//培训名称
    private String org;//培训机构
    private String content;//培训内容

    @DateTimeFormat(pattern = "yyyy-MM")
    @JSONField(format="yyyy-MM")
    private Date beginDate;
    @DateTimeFormat(pattern = "yyyy-MM")
    @JSONField(format="yyyy-MM")
    private Date endDate;

}
