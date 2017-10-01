package com.wonpera.student.bussiness.mapper;

import com.wonpera.student.common.bean.Menu;
import org.apache.ibatis.annotations.Param;

import java.util.List;


@MyBatisRepository
public interface MenuMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Menu record);

    int insertSelective(Menu record);

    Menu selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Menu record);

    int updateByPrimaryKey(Menu record);


    List<Menu> queryUserMenuWithParent(@Param("userId") Long userId, @Param("parentId") Long parentId);
}