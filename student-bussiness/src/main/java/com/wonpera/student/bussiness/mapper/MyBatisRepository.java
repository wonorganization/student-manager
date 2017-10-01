package com.wonpera.student.bussiness.mapper;

import org.springframework.stereotype.Component;

import java.lang.annotation.*;

/**
 * 标识MyBatis的Dao,方便{@link org.mybatis.spring.mapper.MapperScannerConfigurer}的扫描。
 * Created by wangpeng on 2016/12/13.
 */
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
@Documented
@Component
public @interface MyBatisRepository {
}
