package com.wonpera.student.web.config;

import com.wonpera.student.common.constats.GlobConts;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Created by wonpera on 2017/1/3.
 */
@Configuration
public class WebConfig {

    @Bean(name = "gsonFormatter")
    public Gson getFormatterGson(){
        return new GsonBuilder().setDateFormat(GlobConts.DEFAULT_FORMATTER_YYYYMMDDHHMMSS).create();
    }
}
