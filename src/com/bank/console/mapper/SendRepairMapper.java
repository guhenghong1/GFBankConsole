package com.bank.console.mapper;

import org.springframework.stereotype.Repository;

import com.bank.console.equipment.model.SendRepair;

/**
 * 
 * @author zhouzhongxing
 * @since 2016年9月29日
 *
 */
@Repository
public interface SendRepairMapper {
	
	/**
	 * 
	 * @param sendRepair
	 * @return
	 */
	public int addSendRepair(SendRepair sendRepair);

}
