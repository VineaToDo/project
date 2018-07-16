package com.version1.VO;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;

/**
 * @ClassName LanguageVO
 * @Description TODO
 * @Date 2018/5/2 21:45
 * @Version 1.0
 */
@Data
public class LanguageVO implements IdGetter {

    @JSONField(serialize = false)
    private Integer id;
    private Integer name;
    private String literacy;//读写能力
    private String speak;//听说能力

    @JSONField(serialize = false)
    private String nameValue;

}
