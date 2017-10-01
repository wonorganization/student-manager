package com.wonpera.student.bussiness.biz.impl;

import com.wonpera.student.bussiness.biz.MenuService;
import com.wonpera.student.bussiness.mapper.MenuMapper;
import com.wonpera.student.common.bean.Menu;
import com.wonpera.student.common.bean.User;
import com.wonpera.student.common.param.QueryMenuParameter;
import com.wonpera.student.common.response.MenuView;
import com.wonpera.student.common.response.ReturnT;
import com.google.common.collect.Lists;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by wonpera on 2017/2/18.
 */
@Service
public class MenuServiceImpl implements MenuService {


    @Autowired
    private MenuMapper menuMapper;

    @Override
    public ReturnT queryUserMenu(QueryMenuParameter queryMenuParameter) {
        User sessionUser = queryMenuParameter.getSessionUser();
        if(sessionUser  == null){
            //return new ReturnT().failureData("未登录");
            sessionUser = new User();
            sessionUser.setUsername("admin");
            sessionUser.setId(1l);
        }
        Long userId = sessionUser.getId();//当前登陆用户Id
        List<MenuView> list = queryMenuViewByUser(userId,0l);
        return new ReturnT().sucessData(list);
    }


    /**
     * 递归查询菜单以及下属菜单
     * @param userId
     * @param parentId
     * @return
     */
    private List<MenuView> queryMenuViewByUser(Long userId,Long parentId){
        List<MenuView> list = Lists.newArrayList();
        List<Menu> menuList = menuMapper.queryUserMenuWithParent(userId,parentId);
        if(menuList != null && menuList.size() > 0){
            for (Menu menu  : menuList){
                MenuView menuView = new MenuView();
                BeanUtils.copyProperties(menu, menuView);
                List<MenuView> children = queryMenuViewByUser(userId,menuView.getMenuid());
                if(children != null && children.size() > 0){
                    menuView.setChildren(children);
                }
                list.add(menuView);
            }
        }
        return list;
    }
}
