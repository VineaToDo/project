package com.version1.VO;

import lombok.Data;

/**
 * @ClassName QueryComplaint
 * @Description TODO
 * @Date 2018/5/29 20:37
 * @Version 1.0
 */
@Data
public class QueryComplaint {

    private int pageSize;
    private int pageNumber;

    private String sortName;
    private String sortOrder;


}
