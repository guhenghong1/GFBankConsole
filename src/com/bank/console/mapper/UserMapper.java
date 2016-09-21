package com.bank.console.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bank.console.system.form.UserForm;
import com.bank.console.system.model.User;

@Repository
public interface UserMapper {
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
	
	//查询用户列表
	List<User> getUserList(UserForm form);
	
	//查询数量
	int getUserSum(UserForm form);
}
