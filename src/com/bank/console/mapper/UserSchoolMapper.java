package com.bank.console.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bank.console.system.model.UserSchool;

@Repository
public interface UserSchoolMapper {
	//新增用户毕业学校
	int addUserSchool(UserSchool form);
	
	//新增用户毕业学校
	List<UserSchool> getUserSchoolList(@Param("userId") String userId);
	
	//删除用户毕业学校
	int deleteUserSchool(String userId);
	
}
