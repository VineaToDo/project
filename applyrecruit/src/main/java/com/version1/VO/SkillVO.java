package com.version1.VO;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;

/**
 * @ClassName SkillVO
 * @Description TODO
 * @Date 2018/5/3 12:41
 * @Version 1.0
 */
@Data
public class SkillVO implements IdGetter {

    @JSONField(serialize = false)
    private Integer id;
    private String name;//技能名
    private String master;//掌握程度
}
