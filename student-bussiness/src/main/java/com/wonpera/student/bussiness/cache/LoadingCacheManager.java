package com.wonpera.student.bussiness.cache;

import com.google.common.cache.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.concurrent.TimeUnit;

/**
 * guava缓存工具类
 * Created by wangpeng on 2017/1/6.
 */
public class LoadingCacheManager {

    private static final Logger LOGGER = LoggerFactory.getLogger(LoadingCacheManager.class);
    /**
     * 不需要延迟处理(泛型的方式封装)
     * @return
     */
    public static  <K , V> LoadingCache<K , V> cached(CacheLoader<K , V> cacheLoader) {
        return cached(cacheLoader,1,TimeUnit.MINUTES);
    }


    /**
     * 不需要延迟处理(泛型的方式封装)
     * @return
     */
    public static  <K , V> LoadingCache<K , V> cached(CacheLoader<K , V> cacheLoader, long duration, TimeUnit unit) {
        RemovalListener<K, V> listener = new RemovalListener<K, V>(){
            @Override
            public void onRemoval(RemovalNotification<K, V> rn) {
                LOGGER.info(rn.getKey()+"被移除");

            }};
        return cached(cacheLoader,listener,duration,unit);
    }


    public static  <K , V> LoadingCache<K , V> cached(CacheLoader<K , V> cacheLoader, RemovalListener<K, V> listener, long duration, TimeUnit unit) {
        LoadingCache<K , V> cache = CacheBuilder
                .newBuilder()
                .maximumSize(1000)
                .weakKeys()
                .softValues()
                .refreshAfterWrite(duration, unit)
                .expireAfterWrite(duration, unit)
                .removalListener(listener)
                .build(cacheLoader);
        return cache;
    }

}
