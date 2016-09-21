package com.bank.console.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bank.console.dept.model.Dept;
import com.bank.console.dept.vo.DeptVO;

@Repository
public interface DeptMapper {
	/**
	 * 获取列表
	 */
	List<DeptVO> getDeptList();
	
	/**
	 * 获取列表
	 */
	List<DeptVO> getDeptTree();
}
