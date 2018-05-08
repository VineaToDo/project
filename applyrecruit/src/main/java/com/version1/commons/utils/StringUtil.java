package com.version1.commons.utils;

/**
 * @ClassName StringUtil
 * @Description TODO
 * @Date 2018/5/3 17:21
 * @Version 1.0
 */
public class StringUtil {

    public static String toUpperCaseInitial(String string){
        char[] chars = string.toCharArray();
        chars[0] = toUpperCase(chars[0]);
        return String.valueOf(chars);
    }

    public static char toUpperCase(char ch){
        if(ch >= 97 && ch <= 122) ch = (char) (ch - 32);
        return ch;
    }

}
