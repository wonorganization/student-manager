package com.wonpera.student.bussiness.biz;


import com.wonpera.student.bussiness.plugin.PageHelper;
import com.wonpera.student.common.bean.User;
import com.wonpera.student.common.param.AddUserParam;
import com.wonpera.student.common.param.QueryUserParam;
import com.wonpera.student.common.response.ReturnT;

/**
 * Created by wonpera on 2017/2/18.
 */
public interface UserService {

    PageHelper.Page<User> queryUserPage(QueryUserParam param);

    ReturnT login(String username, String password);

    ReturnT saveUser(AddUserParam param);

    ReturnT deleteUser(Long id);


    ReturnT getUserById(Long id);
}
