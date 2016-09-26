package com.bank.console.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.bank.console.customer.model.Customer;
import com.bank.console.customer.vo.CustomerVo;

/**
 * 
 * @author zhouzhongxing
 * @since 2016年9月24日
 *
 */
@Repository
public interface CustomerMapper {
	
	/**
	 * 增加客户
	 * @param customer
	 * @return
	 */
	public int addCustomer(Customer customer);
	
	/**
	 * 删除客户
	 * @param id
	 * @return
	 */
	public int deleteCustomer(String id);
	
	/**
	 * 修改客户
	 * @param customer
	 * @return
	 */
	public int updateCustomer(Customer customer);
	
	/**
	 * 获取客户详情
	 * @param id
	 * @return
	 */
	public CustomerVo getCustomerInfo(String id);
	
	/**
	 * 客户列表
	 * @param param
	 * @return
	 */
	public List<CustomerVo> getCustomerList(Map<String, Object> param);
	
	/**
	 * 查询数量
	 * @param param
	 * @return
	 */
	public int getCustomerSum(Map<String, Object> param);
}
