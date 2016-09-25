package com.bank.console.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bank.console.system.form.UserForm;
import com.bank.console.system.model.User;
import com.bank.console.system.vo.UserVO;

@Repository
public interface UserMapper {
	//新增用户
	int addUser(UserForm user);
	
	//修改用户
	int updateUser(UserForm user);
	
	//删除用户
	int deleteUser(String userId);
	
	//查找用户
	User findUser(String userId);
	
	//获取用户详情
	UserVO getUserInfo(String userId);
	
	//查询用户列表
	List<UserVO> getUserList(UserForm form);
	
	//查询数量
	int getUserSum(UserForm form);
	
}
