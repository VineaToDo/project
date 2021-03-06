package com.version1.commons.utils;

import com.version1.commons.exceptions.ImageAcceptNotSupportException;
import com.version1.commons.exceptions.ImageMaxSizeOverFlow;
import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

/**
 * @ClassName UploadUtil
 * @Description TODO
 * @Date 2018/5/31 13:59
 * @Version 1.0
 */
@Component
@EnableConfigurationProperties(UploadProperty.class)
public class UploadUtil {
    //spring 中无法注入静态变量，只能通过间接注入的方式，使用 @AutoWired直接报错，使用Resource时
    // 直接报找到了2个同样的bean，但是我其实只有1个这样的Bean。
    @Resource(name = "uploadProperty")
    private UploadProperty tempUploadProperty;
    private static UploadProperty uploadProperty;
    // 在servlet中 会在构造函数之后执行, 同样可以实现  InitializingBean 接口
    @PostConstruct
    private void init(){
        uploadProperty = tempUploadProperty;
    }

    /**
     * 图片上传，默认支持所有格式的图片, 文件默认最大为 2MB
     * @param file
     * @return 图片存储路径
     */
    public static String uploadImage(MultipartFile file,String dictoryType) throws ImageMaxSizeOverFlow, ImageAcceptNotSupportException {
        return uploadImageByAcceptType(file,uploadProperty.getAcceptType(),uploadProperty.getMaxSize(),dictoryType);
    }

    /**
     * 图片上传，默认支持所有格式的图片
     * @param file
     * @param maxSize 文件最大多少，单位 mb
     * @return 图片存储路径
     */
    public static String uploadImage(MultipartFile file,int maxSize,String dictoryType) throws ImageMaxSizeOverFlow, ImageAcceptNotSupportException {
        return uploadImageByAcceptType(file,uploadProperty.getAcceptType(),uploadProperty.getMaxSize(),dictoryType);
    }
    /**
     * 上传图片（可限定文件类型）
     * @param file
     * @param acceptTypes  "image/png  image/jpeg  image/jpg"
     * @param maxSize  文件最大为2MB
     * @return 图片存储路径。
     */
    public static String uploadImageByAcceptType(MultipartFile file, List<String> acceptTypes, int maxSize, String dictoryType) throws ImageAcceptNotSupportException, ImageMaxSizeOverFlow {
        String type = file.getContentType();
        if(!acceptTypes.contains(type)){
            throw new ImageAcceptNotSupportException();
        }
        int size = (int) Math.ceil(file.getSize() / 1024 /1024);
        if(size > maxSize) {
            throw new ImageMaxSizeOverFlow();
        }
        String originalFilename = file.getOriginalFilename();
        String suffix = originalFilename.substring(originalFilename.lastIndexOf("."));
//        LocalDate now = LocalDate.now();
//        String year = now.getYear()+"";
//        String month = now.getMonth().getValue()+"";
//        String day = now.getDayOfMonth()+"";
//        Path path = Paths.get(uploadProperty.getPath(), year, month, day);
        Path path = Paths.get(uploadProperty.getPath(), dictoryType);
        String filePath = path.toAbsolutePath().toString();
        File fileDir = new File(filePath);
        if(!fileDir.exists()) fileDir.mkdirs();
        String uuid = UUID.randomUUID().toString() + suffix;
        File realFile = new File(fileDir, uuid);
        try {
            IOUtils.copy(file.getInputStream(),new FileOutputStream(realFile));
        } catch (IOException e) {
            e.printStackTrace();
        }
//        String tempPath =  "/"+year+"/"+month+"/"+day+"/"+uuid;
        String tempPath =  "/"+ dictoryType +"/"+uuid;
        return tempPath;
    }
}
