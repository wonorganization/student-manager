package com.wonpera.student.common.constats;


import com.wonpera.student.common.utils.PropertieUtils;

/**
 * 全局常量
 * Created by wangpeng on 2016/12/13.
 */
public class GlobConts {

    public static final String DEFAULT_FORMATTER_YYYYMMDDHHMMSS = "yyyy-MM-dd HH:mm:ss";


    public static final String DEFAULT_FORMATTER_YYYY_MM_DD = "yyyy-MM-dd";

    public static final String DEFUAL_CHARSET = "UTF-8";

    /**
     * 默认分页大小
     */
    public static final int DEFUALT_PAGE_SIZE = 10;


    public static final Long MAX_EXPIRE_TIME = Long.valueOf(Long.parseLong(String.valueOf(2147483647)) * 1000L);


    /**
     * cookie前缀
     */
    public static final String COOKIE_PREFIX = "Bearer ";


    public static final String SESSION_COOKIE_KEY = "Authorization";


    /**
     * 当前登陆session
     */
    public static final String CURRENT_SESSION_KEY = "current_session";

    public static final String CURRENT_TOKEN_KEY = "current_token";


    /**
     * 图片跟路径
     */
    public static final String IMAGE_ROOT_URL = PropertieUtils.getString("imageRootUrl");


    public static final String IMAGE_LIST_COLUMN = "imgList";


    /**
     * 替换图片字段开头、结尾
     */
    public static final String[] PREFIX = {"imageurl","imageUrl","imgUrl","imgurl"};

    /**
     * 不需要登录的URL
     */
    public static final String[] EXCLUDER_URLS = {"/user/loginUser","/boot/queryValid","/dimNew/getSexEnum","/dimNew/getBigClassEnum"};


    public static final String UPLOAD_IMAGE_FATH = "assets/img/upload/";

    public static final String DEFUALT_PASSWORD = "123456";


    public static final String RESPONSE_ENCODING = "response.encoding";

    public static final String CALLBACK = "callback";
    public static final String JSON_CALLBACK = "jsoncallback";
}
