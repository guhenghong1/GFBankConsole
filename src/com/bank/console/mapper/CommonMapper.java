package com.bank.console.mapper;

import org.apache.ibatis.annotations.Param;

public interface CommonMapper {
	long getMaxId(@Param("tableName") String tableName);
	
	long getMaxIdState(@Param("tableName") String tableName, @Param("id") String id);
}
