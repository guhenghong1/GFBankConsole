package com.bank.console.mapper;

import org.apache.ibatis.annotations.Param;

public interface CommonMapper {
	String getMaxId(@Param("tableName") String tableName);
	
	String getMaxId(@Param("tableName") String tableName, @Param("id") String id);
}
