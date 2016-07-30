package com.water.works.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.water.works.mapper.UserMapper;
import com.water.works.user.model.User;

@Service
public class UserService {
	@Autowired
	private UserMapper userMapper;
	
	public int addUser(User user) {
		return userMapper.addUser(user);
	}
	
	public int updateUser(User user) {
		return userMapper.updateUser(user);
	}
	
	public int deleteUser(int userId) {
		return userMapper.deleteUser(userId);
	}
	
	public User getUserInfo(int userId) {
		return userMapper.getUserInfo(userId);
	}
	
	public List<User> getUserList() {
		return userMapper.getUserList();
	}
}
