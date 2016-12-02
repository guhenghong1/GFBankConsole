package com.bank.console.common.DBIndex;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.support.TransactionTemplate;

import com.bank.console.file.controller.FileController;
import com.bank.console.mapper.CommonMapper;

@Service
public class CommonService {
	@Autowired
	private CommonMapper commonMapper;
	@Autowired
	private TransactionTemplate transactionTemplate;
	
	private static final long INIT_ID = 1;
	
	private static Logger log = Logger.getLogger(CommonService.class);
	
	/**
	 * 获取下一个Id
	 * @param tableName
	 * @return
	 */
	public long getNextId(String tableName) {
		synchronized (tableName) {
			try{
				long maxId = commonMapper.getMaxId(tableName);
				maxId += 1;
				return maxId;
			} catch(Exception e) {
				e.printStackTrace();
				log.error("CommonService create id exception: "+e.getMessage());
				return INIT_ID;
			} 
		}
	}
	
	/**
	 * 获取下一个Id
	 * @param tableName
	 * @return
	 */
	public long getNextId(final String tableName, final String id) {
		synchronized (tableName) {
			try{
				long maxId = commonMapper.getMaxIdState(tableName, id);
				maxId += 1;
				return maxId;
			} catch(Exception e) {
				log.error("CommonService create id exception: "+e.getMessage());
				return INIT_ID;
			} 
		}
	}
}
