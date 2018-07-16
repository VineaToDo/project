package com.version1.VO;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

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
    @DateTimeFormat(pattern = "yyyy-MM")
    @JSONField(format="yyyy-MM")
    private Date obtainTime;

}
