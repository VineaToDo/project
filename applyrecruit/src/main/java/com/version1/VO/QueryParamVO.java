package com.version1.VO;

import lombok.Data;

/**
 * @ClassName QueryParamVO
 * @Description TODO
 * @Date 2018/5/7 15:38
 * @Version 1.0
 */
@Data
public class QueryParamVO {

    private int pageSize;
    private int pageNumber;

    private String property;

}
