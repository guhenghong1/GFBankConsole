package com.bank.console.customer.vo;

import com.bank.console.customer.model.Customer;

/**
 * 
 * @author zhouzhongxing
 * @since 2016年9月26日
 *
 */
public class CustomerVo extends Customer {
	
	private String birthdayStr;	//生日日期字符串
	
	public CustomerVo(){
		
	}

	public String getBirthdayStr() {
		return birthdayStr;
	}

	public void setBirthdayStr(String birthdayStr) {
		this.birthdayStr = birthdayStr;
	}

}
