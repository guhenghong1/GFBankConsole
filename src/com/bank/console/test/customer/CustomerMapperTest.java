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
public class CustomerMapperTest {
	
	@Resource
	private CustomerMapper customerMapper;
	
	@Test
	public void testAddCustomer(){
		for(int i=1; i<20; i++){
			Customer customer = new Customer();
			customer.setId(i + "");
			customer.setManager("1111" + i);
			customer.setAccount("00" + i);
			customer.setName("客户名称" + i);
			if(i%2 == 0){
				customer.setType(1);
				customer.setGrade(1);
			}else{
				customer.setType(2);
				customer.setGrade(2);
			}
			customer.setCardNo("350321" + i);
			customer.setAccount("1990" + i);
			customer.setBirthday(new Date());
			customer.setHobby("爱好" + i);
			customer.setContact("联系方式" + i);
			customer.setRemark("备注" + i);
			
			customerMapper.addCustomer(customer);
		}
	}
	
	@Test
	public void testDeleteCustomer(){
		int count = customerMapper.deleteCustomer("3");
		if(count > 0){
			System.out.println("删除成功");
		}
	}
	
	@Test
	public void testUpdateCustomer(){
		Customer customer = customerMapper.getCustomerInfo("3");
		customer.setManager("13");
		customer.setCardNo("35031245");
		int count = customerMapper.updateCustomer(customer);
		if(count > 0){
			System.out.println("修改成功");
		}
	}
	
	@Test
	public void testGetCustomerInfo(){
		Customer customer = customerMapper.getCustomerInfo("1");
		if(customer != null){
			System.out.println(customer.getName());
		}
	}
	
	@Test
	public void testGetCustomerList(){
		Map<String, Object>  param = new HashMap<String, Object>();
		param.put("name", "11");
		param.put("startRow", 0);
		param.put("endRow", 10);
		List<CustomerVo> list = customerMapper.getCustomerList(param);
		for(CustomerVo customer : list){
			System.out.println(customer.getName());
		}
	}
	
	@Test
	public void testGetCustomerSum(){
		Map<String, Object>  param = new HashMap<String, Object>();
		int count = customerMapper.getCustomerSum(param);
		System.out.println("记录数：" + count);
	}

}
