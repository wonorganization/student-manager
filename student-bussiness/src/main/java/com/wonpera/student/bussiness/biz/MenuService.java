package com.wonpera.student.bussiness.biz;


import com.wonpera.student.common.param.QueryMenuParameter;
import com.wonpera.student.common.response.ReturnT;

/**
 * Created by wonpera on 2017/2/18.
 */
public interface MenuService {

    ReturnT queryUserMenu(QueryMenuParameter queryMenuParameter);

}
