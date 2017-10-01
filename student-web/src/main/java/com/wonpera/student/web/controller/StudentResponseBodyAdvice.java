package com.wonpera.student.web.controller;

import com.wonpera.student.common.constats.GlobConts;
import com.wonpera.student.common.utils.PropertieUtils;
import com.google.gson.Gson;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.MethodParameter;
import org.springframework.core.annotation.Order;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.http.server.ServletServerHttpResponse;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyAdvice;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


/**
* Created by wonpera on 2017/1/7.
*/
@Order(Integer.MAX_VALUE)
@ControllerAdvice(basePackages = "com.wonpera.student.web.controller")
public class StudentResponseBodyAdvice implements ResponseBodyAdvice<Object> {

    @Autowired
    @Qualifier("gsonFormatter")
    private Gson gson;



    @Override
    public boolean supports(MethodParameter returnType, Class<? extends HttpMessageConverter<?>> aClass) {
        return true;
    }

    /**
     * 跨域的处理
     * @param body
     * @param methodParameter
     * @param mediaType
     * @param aClass
     * @param serverHttpRequest
     * @param serverHttpResponse
     * @return
     */
    @Override
    public Object beforeBodyWrite(Object body, MethodParameter methodParameter, MediaType mediaType, Class<? extends HttpMessageConverter<?>> aClass, ServerHttpRequest serverHttpRequest, ServerHttpResponse serverHttpResponse) {
        HttpServletRequest request = ((ServletServerHttpRequest)serverHttpRequest).getServletRequest();
        String jsoncallback = request.getParameter(GlobConts.JSON_CALLBACK);//优先判断jsoncallback
        if(StringUtils.isNoneEmpty(jsoncallback)){
            String result = jsoncallback.concat("(").concat(gson.toJson(body)).concat(")");
            HttpServletResponse response = ((ServletServerHttpResponse)serverHttpResponse).getServletResponse();
            writeResponse(response,result);
            return null;
        }
        String callback = request.getParameter(GlobConts.CALLBACK);//在判断callback
        if(StringUtils.isNoneBlank(callback)){
            String result = callback.concat("(").concat(gson.toJson(body)).concat(")");
            HttpServletResponse response = ((ServletServerHttpResponse)serverHttpResponse).getServletResponse();
            writeResponse(response,result);
            return null;
        }
        return body;
    }


    private void writeResponse(HttpServletResponse response, String result){
        try {
            response.setCharacterEncoding(PropertieUtils.getString(GlobConts.RESPONSE_ENCODING));
            response.getWriter().write(result);
        } catch (IOException e) {

        }
    }




}
