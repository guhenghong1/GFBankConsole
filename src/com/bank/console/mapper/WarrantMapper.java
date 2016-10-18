package com.bank.console.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bank.console.business.form.WarrantForm;
import com.bank.console.business.vo.WarrantVO;

@Repository
public interface WarrantMapper {
	//新增文件
	int addWarrant(WarrantForm form);
	
	//修改文件
	int updateWarrant(WarrantForm form);
	
	//删除文件
	int deleteWarrant(String id);
	
	//获取文件详情
	WarrantVO getWarrantInfo(String id);
	
	//查询列表
	List<WarrantVO> getWarrantList(WarrantForm form);
	
	//查询数量
	int getWarrantSum(WarrantForm form);
	
	List<WarrantVO> getAllWarrantList();
	
	String getMaxid();
}
