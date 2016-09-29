package com.bank.console.equipment.controller;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bank.console.common.Constant;
import com.bank.console.common.interceptor.Permission;
import com.bank.console.common.util.ResultUtil;
import com.bank.console.equipment.model.SendRepair;
import com.bank.console.equipment.service.SendRepairService;

import net.sf.json.JSONObject;

/**
 * 
 * @author zhouzhongxing
 * @since 2016年9月29日
 *
 */
@Controller
@Scope("prototype")
@RequestMapping("/sendRepair")
public class SendRepairController {
	
	@Resource
	private SendRepairService sendRepairService;
	
	@Permission
	@RequestMapping("/addSendRepair")
	@ResponseBody
	public String addSendRepair(SendRepair sendRepair, String buyTimeStr) {
		int res = sendRepairService.addSendRepair(sendRepair);
		
		int code = res >=1? Constant.SUCCESS_CODE: Constant.ERROR_CODE;
		ResultUtil result = new ResultUtil();
		result.setCode(code);
		result.setMsg(Constant.SUCCESS_MSG);
		return JSONObject.fromObject(result).toString();
	}

}
