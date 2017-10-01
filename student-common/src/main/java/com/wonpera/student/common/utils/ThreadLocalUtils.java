package com.wonpera.student.common.utils;

import java.util.HashMap;
import java.util.Map;

/**
 * 本地线程变量工具类
 * Created by wangpeng on 2017/1/6.
 */
public class ThreadLocalUtils {

    private static ThreadLocal<Map<String,Object>> threadLocal = new ThreadLocal<>();

    public static void init() {
        if (threadLocal.get() == null) {
            threadLocal.set(new HashMap<String, Object>());
        }
    }
    public static void destroy() {
        threadLocal.remove();
    }

    public static String getString(String key){
        Object value = getThreadLocalMap().get(key);
        return value != null ? value.toString() : null;
    }

    public static Object getObj(String key){
        return getThreadLocalMap().get(key);
    }

    public static Map<String, Object> getThreadLocalMap() {
        if (threadLocal.get() == null) {
            init();
        }
        return threadLocal.get();
    }

    public static void put(String key, Object value) {
        getThreadLocalMap().put(key, value);
    }
}
