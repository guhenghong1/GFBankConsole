package com.bank.console.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bank.console.system.model.UserHome;

@Repository
public interface UserHomeMapper {
	//新增用户家庭信息
	int addUserHome(UserHome form);
	
	//新增用户家庭信息
	List<UserHome> getUserHomeList(@Param("userId") String userId);
	
	//删除用户家庭信息
	int deleteUserHome(String userId);
	
}
