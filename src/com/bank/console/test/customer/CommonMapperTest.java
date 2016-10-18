package com.bank.console.test.customer;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;

import com.bank.console.customer.model.Customer;
import com.bank.console.customer.vo.CustomerVo;
import com.bank.console.mapper.CommonMapper;
import com.bank.console.mapper.CustomerMapper;

/**
 * 测试类
 * @author zhouzhongxing
 * @since 2016年9月24日
 *
 */
@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations={"classpath:spring-mybatis.xml"})
@TransactionConfiguration(transactionManager="transactionManager",defaultRollback=false)
@Transactional
public class CommonMapperTest {
	
	@Resource
	private CommonMapper commonMapper;
	
	@Test
	public void testGetMaxId(){
		String maxId = commonMapper.getMaxId("tb_conference");
		System.out.println("maxId：" + maxId);
	}
	
	@Test
	public void testGetMaxIdSate(){
		String maxId = commonMapper.getMaxId("tb_dept", "deptId");
		System.out.println("maxId：" + maxId);
	}

}
