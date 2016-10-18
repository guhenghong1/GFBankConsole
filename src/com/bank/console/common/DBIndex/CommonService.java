package com.bank.console.common.DBIndex;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.support.TransactionTemplate;

import com.bank.console.mapper.CommonMapper;

@Service
public class CommonService {
	@Autowired
	private CommonMapper commonMapper;
	@Autowired
	private TransactionTemplate transactionTemplate;
	
	/**
	 * 获取下一个Id
	 * @param tableName
	 * @return
	 */
	public String getNextId(String tableName) {
		synchronized (tableName) {
			String maxIdStr = commonMapper.getMaxId(tableName);
			if(StringUtils.isEmpty(maxIdStr)){
				return "1";
			}
			int maxId = Integer.parseInt(maxIdStr);
			maxId += 1;
			return maxId + "";
		}
	}
	
	/**
	 * 获取下一个Id
	 * @param tableName
	 * @return
	 */
	public String getNextId(final String tableName, final String id) {
		synchronized (tableName) {
			String maxIdStr = commonMapper.getMaxId(tableName, id);
			if(StringUtils.isEmpty(maxIdStr)){
				return "1";
			}
			int maxId = Integer.parseInt(maxIdStr);
			maxId += 1;
			return maxId + "";
		}
	}
}
