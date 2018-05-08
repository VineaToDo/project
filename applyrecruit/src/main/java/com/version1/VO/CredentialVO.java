package com.version1.VO;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;

import java.util.Date;

/**
 * @ClassName CredentialVO
 * @Description TODO
 * @Date 2018/5/2 22:57
 * @Version 1.0
 */
@Data
public class CredentialVO implements IdGetter {

    @JSONField(serialize = false)
    private Integer id;
    private String name;
    @JSONField(format="yyyy-MM")
    private Date obtainTime;

}
