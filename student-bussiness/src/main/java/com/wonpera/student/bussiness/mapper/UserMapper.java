package com.wonpera.student.bussiness.mapper;

import com.wonpera.student.common.bean.User;

import java.util.List;


@MyBatisRepository
public interface UserMapper {
    int deleteByPrimaryKey(Long id);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    List<User> query(User user);
}