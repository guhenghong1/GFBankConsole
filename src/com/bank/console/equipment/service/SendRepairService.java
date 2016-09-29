package com.bank.console.equipment.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bank.console.equipment.model.SendRepair;
import com.bank.console.mapper.SendRepairMapper;

/**
 * 
 * @author zhouzhongxing
 * @since 2016年9月29日
 *
 */
@Service
public class SendRepairService {
	
	@Resource
	private SendRepairMapper sendRepairMapper;
	
	public int addSendRepair(SendRepair sendRepair){
		return sendRepairMapper.addSendRepair(sendRepair);
	}

}
