package com.bank.console.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bank.console.system.form.MenuForm;
import com.bank.console.system.vo.MenuVO;

@Repository
public interface MenuMapper {
	/**
	 * 新增
	 */
	int addMenu(MenuForm form);
	
	/**
	 * 修改
	 */
	int updateMenu(MenuForm form);
	
	/**
	 * 删除
	 */
	int deleteMenu(String menuId);
	
	/**
	 * 获取列表
	 */
	List<MenuVO> getMenuList();
	
	/**
	 * 获取列表
	 */
	List<MenuVO> getLevelMenuList(@Param("menuId")String menuId);
	
	MenuVO getMenuInfo(@Param("menuId")String menuId);
	
}
