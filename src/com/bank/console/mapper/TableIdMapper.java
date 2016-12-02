package com.bank.console.mapper;

import com.bank.console.system.model.TableId;

public interface TableIdMapper {
	int addTableId(TableId tableId);
	
	TableId getTableId(String tableName);
	
	int updateTableId(TableId tableId);
}
