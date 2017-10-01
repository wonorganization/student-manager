package com.wonpera.student.web.controller;

import com.wonpera.student.bussiness.biz.UserService;
import com.wonpera.student.bussiness.plugin.PageHelper;
import com.wonpera.student.common.bean.User;
import com.wonpera.student.common.constats.GlobConts;
import com.wonpera.student.common.param.AddUserParam;
import com.wonpera.student.common.param.QueryUserParam;
import com.wonpera.student.common.response.ReturnT;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

/**
 * Created by wonpera on 2017/2/18.
 */
@RestController
@RequestMapping("user")
public class UserController {

    @Autowired
    private UserService userService;


    /**
     * 跳转到列表页面
     * @return
     */
    @RequestMapping("list")
    public ModelAndView listPage(){
        return new ModelAndView("user/user-list");
    }


    /**
     * 查询分页列表
     * @param param
     * @return
     */
    @RequestMapping("page")
    public PageHelper.Page<User> queryUserPage(QueryUserParam param){
        return userService.queryUserPage(param);
    }


    /**
     * 用户新增
     * @param param
     * @return
     */
    @RequestMapping(value = "save",method = RequestMethod.POST)
    public ReturnT saveUser(AddUserParam param){
        return userService.saveUser(param);
    }


    /**
     * 用户修改
     * @param param
     * @return
     */
    /*@RequestMapping(value = "update",method = RequestMethod.POST)
    public ReturnT updateUser(UpdUserParam param){
        return userService.updateUser(param);
    }*/


    /**
     * 用户删除
     * @param id
     * @return
     */
    @RequestMapping(value = "delete",method = RequestMethod.POST)
    public ReturnT deleteUser(@RequestParam(value = "id")Long id){
        return userService.deleteUser(id);
    }


    /**
     * 登陆
     * @param username
     * @param password
     * @param session
     * @return
     */
    @RequestMapping("login")
    public ReturnT login(@RequestParam(value = "username")String username,
                         @RequestParam(value = "password")String password, HttpSession session){
        ReturnT returnT = userService.login(username,password);
        if(returnT.isSuccess()){
            //登录信息
            session.setAttribute(GlobConts.CURRENT_SESSION_KEY, returnT.getData());
        }
        return returnT;
    }


    @RequestMapping("getUserById")
    public ReturnT getUserById(@RequestParam(value = "id")Long id){
        return userService.getUserById(id);
    }
}
