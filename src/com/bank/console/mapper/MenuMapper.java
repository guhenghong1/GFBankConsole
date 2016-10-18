package com.bank.console.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bank.console.system.vo.MenuVO;

@Repository
public interface MenuMapper {
	/**
	 * 获取列表
	 */
	List<MenuVO> getMenuList();
	
}
