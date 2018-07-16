package com.version1.VO;

import lombok.Data;

/**
 * @ClassName QueryUserVO
 * @Description TODO
 * @Date 2018/5/28 22:55
 * @Version 1.0
 */
@Data
public class QueryUserVO {

    private int pageSize;
    private int pageNumber;
    private String sortName;
    private String sortOrder;

    private String roleName;

    private Integer resumeId;

    private Boolean available;

}
