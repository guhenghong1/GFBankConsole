package com.bank.console.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bank.console.system.model.MenuOperate;

@Repository
public interface MenuOperateMapper {
	int addMenuOperate(MenuOperate menuOperate);
	
	int deleteMenuOperate(String menuId);
	
	List<MenuOperate> getMenuOperate(String menuId);
}
