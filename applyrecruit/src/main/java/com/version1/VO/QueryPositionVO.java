package com.version1.VO;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * @ClassName QueryPositionVO
 * @Description TODO
 * @Date 2018/5/7 15:38
 * @Version 1.0
 */
@Data
public class QueryPositionVO {

    private int pageSize;
    private int pageNumber;
    private String sortName;
    private String sortOrder;

    private Integer positionId;//职位ID

    private String property;//性质列表

    private Integer typeId;//分类列表

    private boolean collect = false;//收藏列表

    private Integer userId;//用户ID

    private Integer state;//职位状态

    private Integer companyId;//公司ID

    private Integer deptId;//部门名
    private String positionKey;//职位关键字

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date beginDate;//发布日期
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date endDate;//截止日期


}
