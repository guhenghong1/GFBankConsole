package com.water.works.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.water.works.user.model.User;

@Repository
public interface UserMapper {
	int addUser(User user);
	
	int updateUser(User user);
	
	User getUserInfo(int userId);
	
	List<User> getUserList();
	
	int deleteUser(int userId);
}
