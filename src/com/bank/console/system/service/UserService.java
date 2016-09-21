package com.bank.console.system.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bank.console.common.Constant;
import com.bank.console.common.util.MD5Util;
import com.bank.console.mapper.UserMapper;
import com.bank.console.system.form.UserForm;
import com.bank.console.system.model.User;

@Service
public class UserService {
	@Autowired
	private UserMapper userMapper;
	
	public User findUser(String userId) {
		return userMapper.findUser(userId);
	}
	
	public int addUser(User user) {
		return userMapper.addUser(user);
	}
	
	public int updateUser(User user) {
		return userMapper.updateUser(user);
	}
	
	public int deleteUser(String userId) {
		return userMapper.deleteUser(userId);
	}
	
	public User getUserInfo(String userId) {
		return userMapper.getUserInfo(userId);
	}
	
	/**
	 * 查询用户列表
	 * @param form
	 * @return
	 */
	public List<User> getUserList(UserForm form) {
		return userMapper.getUserList(form);
	}
	
	/**
	 * 查询数量
	 * @param form
	 * @return
	 */
	public int getUserSum(UserForm form) {
		return userMapper.getUserSum(form);
	}
	
	/**
	 * 用户状态
	 * @param userId
	 * @param pass
	 * @return
	 */
	public int userStatus(String userId, String pass) {
		pass = MD5Util.getMD5Code(pass);
		User user = this.getUserInfo(userId);
		if(user == null) {	//用户不存在
			return Constant.USER_NOT_EXIST;
		} 
		
		if(!MD5Util.getMD5Code(pass).equals(user.getPass())) { //密码错误
			return Constant.PWD_ERROR;
		} else {	//成功
			return Constant.SUCCESS_CODE;
		}
	}
}
