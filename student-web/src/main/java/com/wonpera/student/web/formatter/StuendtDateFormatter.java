package com.wonpera.student.web.formatter;

import com.wonpera.student.common.constats.GlobConts;
import org.springframework.format.Formatter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

/**
 * Created by wonpera on 2017/1/7.
 */
public class StuendtDateFormatter implements Formatter<Date> {
    @Override
    public Date parse(String s, Locale locale) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat(GlobConts.DEFAULT_FORMATTER_YYYY_MM_DD);
        return sdf.parse(s);
    }

    @Override
    public String print(Date date, Locale locale) {
        return null;
    }
}
