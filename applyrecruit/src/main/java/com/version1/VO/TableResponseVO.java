package com.version1.VO;

import com.version1.entity.Department;
import lombok.Data;

import java.util.List;

/**
 * @ClassName TableResponseVO
 * @Description TODO
 * @Date 2018/5/7 15:44
 * @Version 1.0
 */
@Data
public class TableResponseVO {

    private int total;
    private List rows;

}