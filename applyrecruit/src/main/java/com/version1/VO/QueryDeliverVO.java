package com.version1.VO;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * @ClassName QueryDeliverVO
 * @Description TODO
 * @Date 2018/5/24 23:35
 * @Version 1.0
 */
@Data
public class QueryDeliverVO {

    private int pageSize;
    private int pageNumber;

    private String sortName;
    private String sortOrder;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date selectedDate;

    private Integer companyId;//公司ID

    private Integer resumeId;//根据求职者简历ID取得投递记录

    private Integer positionId;//对应职位的投递

    private Boolean isCollected;//HR收藏夹

    private Byte[] available;//处理状态分类列表

    private Boolean informed;//被投诉求职者

}
