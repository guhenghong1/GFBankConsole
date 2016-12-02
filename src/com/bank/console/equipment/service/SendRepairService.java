package com.bank.console.equipment.service;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bank.console.common.DBIndex.CommonService;
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
	@Autowired
	private CommonService commonService;
//	@Autowired
//	private TableIdService tableIdService;
	
	private static final String TABLE_NAME = "tb_send_repair";
	
	public int addSendRepair(SendRepair sendRepair){
		long nextId = commonService.getNextId(TABLE_NAME);
		sendRepair.setId(nextId);
		return sendRepairMapper.addSendRepair(sendRepair);
	}

}
