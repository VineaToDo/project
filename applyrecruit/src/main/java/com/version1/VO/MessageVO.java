package com.version1.VO;

import lombok.Data;

import java.util.Date;

/**
 * @ClassName MessageVO
 * @Description TODO
 * @Date 2018/5/27 22:52
 * @Version 1.0
 */
@Data
public class MessageVO {

    private byte available;//职位投递状态

    private String positionName;//职位名称

    public MessageVO() {
    }

    public MessageVO(byte available, String positionName) {
        this.available = available;
        this.positionName = positionName;
    }

}
