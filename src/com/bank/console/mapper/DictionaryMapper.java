package com.bank.console.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bank.console.business.model.Dictionary;

@Repository
public interface DictionaryMapper {
	/**
	 * 新增机构
	 */
	int addDictionary(Dictionary dic);
	
	/**
	 * 删除机构
	 */
	int deleteDictionary(String DictionaryId);
	
	/**
	 * 删除机构
	 */
	Dictionary getDictionaryInfo(@Param("name")String name, @Param("type")int type);
	
	/**
	 * 获取列表
	 */
	List<Dictionary> getDictionaryList(@Param("name")String name, @Param("type")int type);
	
	/**
	 *
	 */
	String getMaxid();
}
