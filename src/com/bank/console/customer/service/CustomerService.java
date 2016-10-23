package com.bank.console.customer.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bank.console.common.util.CSVUtil;
import com.bank.console.customer.model.Customer;
import com.bank.console.customer.vo.CustomerVo;
import com.bank.console.mapper.CustomerMapper;
import com.bank.console.system.form.UserForm;
import com.bank.console.system.vo.UserVO;

/**
 * 
 * @author zhouzhongxing
 * @since 2016年9月24日
 *
 */
@Service
public class CustomerService {
	
	@Resource
	private CustomerMapper customerMapper;
	
	/**
	 * 增加客户
	 * @param customer
	 * @return
	 */
	public int addCustomer(Customer customer){
		return customerMapper.addCustomer(customer);
	}
	
	/**
	 * 删除客户
	 * @param id
	 * @return
	 */
	public int deleteCustomer(String id){
		return customerMapper.deleteCustomer(id);
	}
	
	/**
	 * 修改客户
	 * @param customer
	 * @return
	 */
	public int updateCustomer(Customer customer){
		return customerMapper.updateCustomer(customer);
	}
	
	/**
	 * 获取客户详情
	 * @param id
	 * @return
	 */
	public CustomerVo getCustomerInfo(String id){
		return customerMapper.getCustomerInfo(id);
	}
	
	/**
	 * 客户列表
	 * @param param
	 * @return
	 */
	public List<CustomerVo> getCustomerList(Map<String, Object> param){
		return customerMapper.getCustomerList(param);
	}
	
	/**
	 * 查询数量
	 * @param param
	 * @return
	 */
	public int getCustomerSum(Map<String, Object> param){
		return customerMapper.getCustomerSum(param);
	}

}
