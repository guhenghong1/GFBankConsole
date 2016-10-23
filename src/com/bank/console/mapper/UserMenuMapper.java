package com.bank.console.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bank.console.system.model.UserMenu;
import com.bank.console.system.vo.UserMenuVO;

@Repository
public interface UserMenuMapper {
	//新增用户毕业学校
	int addUserMenu(UserMenu form);
	
	//新增用户毕业学校
	List<UserMenuVO> getUserMenuList(@Param("userId") String userId);
	
	//删除用户毕业学校
	int deleteUserMenu(String userId);
	
	UserMenuVO getUserMenu(@Param("userId") String userId, @Param("menuId") String menuId);
	
}
