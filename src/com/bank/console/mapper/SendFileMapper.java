package com.bank.console.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bank.console.system.model.User;

@Repository
public interface SendFileMapper {
	//新增用户
	int addUser(User user);
	
	//修改用户
	int updateUser(User user);
	
	//删除用户
	int deleteUser(String userId);
	
	//查找用户
	User findUser(String userId);
	
	//获取用户详情
	User getUserInfo(String userId);
	
	List<User> getUserList(@Param("user") User user, @Param("roles") List roles);
	
	
}
