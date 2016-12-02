package com.bank.console.test.customer;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;

import com.bank.console.equipment.model.SendRepair;
import com.bank.console.mapper.SendRepairMapper;

/**
 * 
 * @author zhouzhongxing
 * @since 2016年9月29日
 *
 */
@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations={"classpath:spring-mybatis.xml"})
@TransactionConfiguration(transactionManager="transactionManager",defaultRollback=false)
@Transactional
public class SendRepairMapperTest {
	
	@Resource
	private SendRepairMapper sendRepairMapper;
	
	@Test
	public void testSave(){
		SendRepair sendRepair = new SendRepair();
		sendRepair.setEquipmentId("4");
		sendRepairMapper.addSendRepair(sendRepair);
	}

}
