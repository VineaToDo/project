package com.version1.VO;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * @ClassName EducationVO
 * @Description TODO
 * @Date 2018/4/24 20:18
 * @Version 1.0
 */
@Data
public class EducationVO implements IdGetter {

    @JSONField(serialize=false)
    private Integer id;
//    @JSONField(serialize = false)
//    private Integer eduid;
    @DateTimeFormat(pattern = "yyyy-MM")
    @JSONField(format="yyyy-MM")
    private Date beginDate;
    @DateTimeFormat(pattern = "yyyy-MM")
    @JSONField(format="yyyy-MM")
    private Date endDate;
    private String school;
    private String major;//专业
    private Integer degree;//学历
    private Integer single;//是否统一招生

    @JSONField(serialize = false)
    private String degreeValue;

//    @JSONField(serialize = false)
//    public EduDgreeEnum getEduDgreeEnum(){
//        return EnumUtil.getByCode(degree,EduDgreeEnum.class);
//    }

}
