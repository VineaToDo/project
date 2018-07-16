package com.version1.commons.utils;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * @ClassName UploadProperty
 * @Description TODO
 * @Date 2018/5/31 13:55
 * @Version 1.0
 */
@Component
@ConfigurationProperties(prefix = "upload.image")
@Getter
@Setter
public class UploadProperty {
    private String path;
    private int maxSize;
    private List<String> acceptType = new ArrayList<>();

    @Override
    public String toString() {
        return "UploadProperty{" +
                "path='" + path + '\'' +
                ", maxSize=" + maxSize +
                ", acceptType=" + acceptType +
                '}';
    }
}
