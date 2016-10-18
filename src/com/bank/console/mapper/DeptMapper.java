package com.bank.console.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bank.console.dept.form.DeptForm;
import com.bank.console.dept.vo.DeptVO;

@Repository
public interface DeptMapper {
	/**
	 * 新增机构
	 */
	int addDept(DeptForm form);
	
	/**
	 * 修改机构
	 */
	int updateDept(DeptForm form);
	
	/**
	 * 删除机构
	 */
	int deleteDept(String deptId);
	
	/**
	 * 删除机构
	 */
	DeptVO getDeptInfo(String deptId);
	
	/**
	 * 获取列表
	 */
	List<DeptVO> getDeptList();
	
	/**
	 * 获取列表
	 */
	String getMaxDeptId();
}
