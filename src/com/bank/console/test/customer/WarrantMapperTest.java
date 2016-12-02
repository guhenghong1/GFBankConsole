package com.bank.console.test.customer;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;

import com.bank.console.business.service.WarrantService;
import com.bank.console.mapper.CommonMapper;

/**
 * 测试类
 * @author 
 * @since 2016年9月24日
 *
 */
@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations={"classpath:spring-mybatis.xml"})
@TransactionConfiguration(transactionManager="transactionManager",defaultRollback=false)
@Transactional
public class WarrantMapperTest {
	@Autowired
	private WarrantService warrantService;
	
	@Resource
	private CommonMapper commonMapper;
	
//	@Test
//	public void testGetMaxId(){
//		long maxId = commonMapper.getMaxId("tb_conference");
//		System.out.println("maxId：" + maxId);
//	}
	
	@Test
	public void testDelete(){
		int i = warrantService.deleteWarrant("6");
		System.out.println("i：" + i);
	}

}
