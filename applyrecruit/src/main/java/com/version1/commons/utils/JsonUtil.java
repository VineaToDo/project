package com.version1.commons.utils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.alibaba.fastjson.serializer.SerializeConfig;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.alibaba.fastjson.serializer.SimpleDateFormatSerializer;
import lombok.extern.slf4j.Slf4j;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @ClassName JsonUtil
 * @Description json工具处理类
 * @Date 2018/4/21 20:05
 * @Version 1.0
 **/
@Slf4j
public class JsonUtil {
    private static final SerializeConfig config;
    static{
        config = new SerializeConfig();
        config.put(Date.class, new SimpleDateFormatSerializer("yyyy-MM"));
    }
    private static final SerializerFeature[] features = {
            SerializerFeature.WriteMapNullValue, // 输出空置字段
            SerializerFeature.WriteNullListAsEmpty, // list字段如果为null，输出为[]，而不是null
            SerializerFeature.WriteNullNumberAsZero, // 数值字段如果为null，输出为0，而不是null
            SerializerFeature.WriteNullBooleanAsFalse, // Boolean字段如果为null，输出为false，而不是null
            SerializerFeature.WriteNullStringAsEmpty // 字符类型字段如果为null，输出为""，而不是null
    };

    public static String toJsonStringNoFeatrues(Object object){
        return JSON.toJSONString(object, config);
    }

    public static String toJsonString(Object object){
        return JSON.toJSONString(object, config, features);
    }
    /**
     * @Description json字符串转化为简单Object对象
     * @Date 16:42 2018/4/22
     * @Param [jsonString]
     * @return java.lang.Object
     */
    public static Object jsonToBean(String jsonString){
        Object object = null;
        try {
            object = JSON.parse(jsonString);
        } catch (Exception e) {
            log.error("json字符串转换object失败！" + jsonString, e);
        }
        return object;
    }
    /**
     * @Description json字符串转化为对应的JavaBean
     * @Date 16:40 2018/4/22
     * @Param [jsonString, clazz]
     * @return T
     */
    public static <T> T jsonToBean(String jsonString ,Class<T> clazz){
        T t = null;
        try {
            t = JSON.parseObject(jsonString, clazz);
        } catch (Exception e) {
            log.error("json字符串转换bean失败！" + jsonString, e);
        }
        return t;
    }
    /**
     * @Description json字符串转化为对应的List集合
     * @Date 16:55 2018/4/22
     * @Param [jsonString, clazz]
     * @return java.util.List<T>
     */
    public static <T> List<T> jsontoList(String jsonString, Class<T> clazz){
        List<T> list = new ArrayList<T>();
        try {
            list = JSON.parseArray(jsonString, clazz);
        } catch (Exception e) {
            log.error("json字符串转list失败！" + jsonString, e);
        }
        return list;
    }
    /**
     * @Description json字符串转化为Map
     * @Date 17:06 2018/4/22
     * @Param [jsonString]
     * @return java.util.Map<java.lang.String,java.lang.Object>
     */
    public static Map<String,Object> jsonToMap(String jsonString){
        try {
            return JSON.parseObject(jsonString, Map.class);
        } catch (Exception e) {
            log.error("json字符串转换map失败！" + jsonString, e);
        }
        return null;
    }
    /**
     * @Description json字符串转化为List<Map>
     * @Date 17:07 2018/4/22
     * @Param [jsonString]
     * @return java.util.List<java.util.Map<java.lang.String,java.lang.Object>>
     */
    public static List<Map<String, Object>> listKeyMaps(String jsonString) {
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        try {
            list = JSON.parseObject(jsonString,
                    new TypeReference<List<Map<String, Object>>>() {
                    });
        } catch (Exception e) {
            log.error("json字符串转list<map>失败", e);
        }
        return list;
    }
}
