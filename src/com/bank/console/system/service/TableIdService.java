package com.bank.console.system.service;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.TransactionCallback;
import org.springframework.transaction.support.TransactionTemplate;

import com.bank.console.file.controller.FileController;
import com.bank.console.mapper.TableIdMapper;
import com.bank.console.system.model.TableId;

@Service
public class TableIdService {
	@Autowired
	private TableIdMapper tableIdMapper;
	@Autowired
	private TransactionTemplate transactionTemplate;

	private static final long INIT_ID = 1; // 初始化值

	private static Logger log = Logger.getLogger(FileController.class);

	public long getNextId1(final String tableName) {
		synchronized (tableName) {
			return (Integer) transactionTemplate.execute(new TransactionCallback() {
				@Override
				public Object doInTransaction(TransactionStatus status) {
					long nextId = 0;
					try {
						TableId tableId = tableIdMapper.getTableId(tableName);
						long maxId = 0;
						if (tableId != null) {
							maxId = tableId.getMaxId();
							nextId = maxId + 1;
						} else {
							nextId = INIT_ID;
						}

						tableId.setTableName(tableName);
						tableId.setMaxId(nextId);
						int res = tableIdMapper.updateTableId(tableId);

						return nextId;
					} catch (Exception e) {
						status.setRollbackOnly();
						log.error("getNextId error: "+e.getMessage());
						return INIT_ID;
					}
				}
			});
		}
	}
}
