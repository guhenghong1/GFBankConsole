package com.bank.console.customer.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bank.console.common.Constant;
import com.bank.console.common.PageCalc;
import com.bank.console.common.Pager;
import com.bank.console.common.interceptor.Permission;
import com.bank.console.common.util.DateUtil;
import com.bank.console.common.util.ResultUtil;
import com.bank.console.customer.model.Customer;
import com.bank.console.customer.service.CustomerService;
import com.bank.console.customer.vo.CustomerVo;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 
 * @author zhouzhongxing
 * @since 2016年9月24日
 *
 */
@Controller
@Scope("prototype")
@RequestMapping("/customer")
public class CustomerController {
	
	@Resource
	private CustomerService customerService;
	
	@Permission
	@RequestMapping("/init")
	public String init() {
		return "customer/customer";
	}
	
	@Permission
	@RequestMapping("/getCustomerList")
	@ResponseBody
	public String getCustomerList(@RequestParam("id") String id,
			@RequestParam("name") String name, 			
			@RequestParam(value="pageNum", defaultValue="1") String pageNum,
			@RequestParam(value="pageSize", defaultValue="10") String pageSize) {
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("id", id); 
		param.put("name", name); 
		
		int total = customerService.getCustomerSum(param);
		
		PageCalc calc = new PageCalc(total);
		param.put("startRow", calc.getStart(Integer.parseInt(pageNum)));
		param.put("endRow", calc.getEnd(Integer.parseInt(pageNum)));

		List<CustomerVo> userList = customerService.getCustomerList(param);
		
		JSONArray jsonArr = new JSONArray();
		jsonArr = JSONArray.fromObject(userList);
		
		Pager pager = new Pager();
		pager.setTotal(total);
		pager.setRows(jsonArr);
		
		return JSONObject.fromObject(pager).toString();
	}
	
	@RequestMapping("/getCustomerInfo")
	@ResponseBody
	public String getCustomerInfo(String id) {
		CustomerVo customer = customerService.getCustomerInfo(id);
		return JSONObject.fromObject(customer).toString();
	}

	@Permission
	@RequestMapping("/updateCustomer")
	@ResponseBody
	public String updateCustomer(CustomerVo customer, String birthdayStr) {
		if(StringUtils.isNotEmpty(birthdayStr)){
			customer.setBirthday(DateUtil.strToDate(birthdayStr, "yyyy-MM-dd"));
		}
		int res = customerService.updateCustomer(customer);
		
		int code = res >=1? Constant.SUCCESS_CODE: Constant.ERROR_CODE;
		ResultUtil result = new ResultUtil();
		result.setCode(code);
		result.setMsg(Constant.SUCCESS_MSG);
		return JSONObject.fromObject(result).toString();
	}
	
	@Permission
	@RequestMapping("/deleteCustomer")
	@ResponseBody
	public String deleteCustomer(String id) {
		int res = customerService.deleteCustomer(id);
		
		int code = res >=1? Constant.SUCCESS_CODE: Constant.ERROR_CODE;
		ResultUtil result = new ResultUtil();
		result.setCode(code);
		result.setMsg(Constant.SUCCESS_MSG);
		return JSONObject.fromObject(result).toString();
	}
	
	@Permission
	@RequestMapping("/addCustomer")
	@ResponseBody
	public String addCustomer(Customer customer, String birthdayStr) {
		if(StringUtils.isNotEmpty(birthdayStr)){
			customer.setBirthday(DateUtil.strToDate(birthdayStr, "yyyy-MM-dd"));
		}
		
		int res = customerService.addCustomer(customer);
		
		int code = res >=1? Constant.SUCCESS_CODE: Constant.ERROR_CODE;
		ResultUtil result = new ResultUtil();
		result.setCode(code);
		result.setMsg(Constant.SUCCESS_MSG);
		return JSONObject.fromObject(result).toString();
	}

}
