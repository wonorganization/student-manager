package com.wonpera.student.common.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Administrator on 2017/2/15.
 */
public class DateUtils {

    public static String FORMAT_YYYYMMDD = "YYYY-MM-DD";
    public static String FORMAT_YYYYMMDDHHMMSS = "yyyyMMddHHmmss";

    public static String formatNowDate(String format){
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        Date now = new Date();
        return sdf.format(now);
    }
}
