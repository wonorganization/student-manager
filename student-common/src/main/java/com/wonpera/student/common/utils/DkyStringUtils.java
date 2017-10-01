package com.wonpera.student.common.utils;

import java.util.UUID;

/**
 * Created by wangpeng on 2017/1/4.
 */
public class DkyStringUtils {


    /**
     * 获取UUID
     * @return
     */
    public static String uuidString(){
        return  UUID.randomUUID().toString().replaceAll("-", "");
    }


    /**
     * 获取一个字符串开始字符到结束字符之间的内容
     * @param content 内容
     * @param prefix  开始字符
     * @param suffix  结束字符
     * @return
     */
    public static String getMiddleText(String content, String prefix, String suffix) {
        return getMiddleText(content, prefix, suffix, true, true);
    }

    public static String getMiddleText(String content, String prefix, String suffix, boolean lazyPrefix, boolean lazySuffix) {
        if(content != null) {
            int prefixIndex;
            if(prefix != null && suffix != null) {
                prefixIndex = lazyPrefix?content.indexOf(prefix):content.lastIndexOf(prefix);
                if(prefixIndex >= 0) {
                    String tail = content.substring(prefixIndex + prefix.length());
                    int suffixIndex = lazySuffix?tail.indexOf(suffix):tail.lastIndexOf(suffix);
                    if(suffixIndex > 0) {
                        return tail.substring(0, suffixIndex);
                    }
                }
            } else if(prefix == null && suffix != null) {
                prefixIndex = lazySuffix?content.indexOf(suffix):content.lastIndexOf(suffix);
                if(prefixIndex > 0) {
                    return content.substring(0, prefixIndex);
                }
            } else if(prefix != null && suffix == null) {
                prefixIndex = lazyPrefix?content.indexOf(prefix):content.lastIndexOf(prefix);
                if(prefixIndex >= 0) {
                    return content.substring(prefixIndex + prefix.length(), content.length());
                }
            }
        }

        return null;
    }
}
