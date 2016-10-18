package com.bank.console.system.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bank.console.common.Constant;
import com.bank.console.common.PageCalc;
import com.bank.console.common.Pager;
import com.bank.console.common.interceptor.Permission;
import com.bank.console.common.util.DateUtil;
import com.bank.console.common.util.MD5Util;
import com.bank.console.common.util.ResultUtil;
import com.bank.console.system.form.UserForm;
import com.bank.console.system.form.UserMenuForm;
import com.bank.console.system.service.UserMenuService;
import com.bank.console.system.service.UserService;
import com.bank.console.system.vo.UserVO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	private UserService userService;
	@Autowired
	private UserMenuService userMenuService;
	
	private static final String INIT_PWD = "888888";	//初始化密码

	@Permission
	@RequestMapping("/init")
	public String init() {
		return "user/user";
	}

	/**
	 * 查询用户列表
	 * @param userId
	 * @param realName
	 * @param deptId
	 * @param phone
	 * @param mobile
	 * @param pageNum
	 * @param pageSize
	 * @return
	 */
	@Permission
	@RequestMapping("/getUserList")
	@ResponseBody
	public String getUserList(@RequestParam("userId") String userId,
			@RequestParam("realName") String realName, 			
			@RequestParam("deptId") String deptId,
			@RequestParam("phone") String phone,
			@RequestParam("mobile") String mobile,
			@RequestParam(value="pageNum", defaultValue="1") String pageNum,
			@RequestParam(value="pageSize", defaultValue="10") String pageSize) {
		UserForm form = new UserForm();
		form.setUserId(userId);
		form.setDeptId(deptId);
		form.setRealName(realName);
		form.setPhone(phone);
		form.setMobile(mobile);
		
		int total = userService.getUserSum(form);
		PageCalc calc = new PageCalc(total);
		form.setStartRow(calc.getStart(Integer.parseInt(pageNum)));
		form.setEndRow(calc.getEnd(Integer.parseInt(pageNum)));
		
		List<UserVO> userList = userService.getUserList(form);
		JSONArray jsonArr = new JSONArray();
		jsonArr = JSONArray.fromObject(userList);
		
		Pager pager = new Pager();
		pager.setTotal(total);
		pager.setRows(jsonArr);
		return JSONObject.fromObject(pager).toString();
	}
	
	@RequestMapping("/getUserInfo")
	@ResponseBody
	public String getUserInfo(@RequestParam("userId") String userId) {
		UserVO user = userService.getUserInfo(userId);
		return JSONObject.fromObject(user).toString();
	}

	@Permission
	@RequestMapping("/updateUser")
	@ResponseBody
	public String updateUser(@ModelAttribute("userForm") UserForm form) {
		Date birthday = DateUtil.strToDate(form.getEntryDateStr(), DateUtil.str2CalenderFormate);
		if(birthday != null) {
			form.setBirthday(birthday);
		}
		Date entryDate = DateUtil.strToDate(form.getEntryDateStr(), DateUtil.str2CalenderFormate);
		if(entryDate != null) {
			form.setEntryDate(entryDate);
		}
		
		int res = userService.updateUser(form);
		
		int code = res >=1? Constant.SUCCESS_CODE: Constant.ERROR_CODE;
		ResultUtil result = new ResultUtil();
		result.setCode(code);
		result.setMsg(Constant.SUCCESS_MSG);
		return JSONObject.fromObject(result).toString();
	}
	
	@Permission
	@RequestMapping("/deleteUser")
	@ResponseBody
	public String deleteUser(@RequestParam("userId") String userId) {
		int res = userService.deleteUser(userId);
		
		int code = res >=1? Constant.SUCCESS_CODE: Constant.ERROR_CODE;
		ResultUtil result = new ResultUtil();
		result.setCode(code);
		result.setMsg(Constant.SUCCESS_MSG);
		return JSONObject.fromObject(result).toString();
	}
	
	@Permission
	@RequestMapping("/addUser")
	@ResponseBody
	public String addUser(@ModelAttribute("userForm") UserForm form) {
		form.setPass(MD5Util.getMD5Code(INIT_PWD));
		Date birthday = DateUtil.strToDate(form.getBirthdayStr(), DateUtil.str2CalenderFormate);
		if(birthday != null) {
			form.setBirthday(birthday);
		}
		Date entryDate = DateUtil.strToDate(form.getEntryDateStr(), DateUtil.str2CalenderFormate);
		if(entryDate != null) {
			form.setEntryDate(entryDate);
		}
		
		int res = userService.addUser(form);
		
		int code = res >=1? Constant.SUCCESS_CODE: Constant.ERROR_CODE;
		ResultUtil result = new ResultUtil();
		result.setCode(code);
		result.setMsg(Constant.SUCCESS_MSG);
		return JSONObject.fromObject(result).toString();
	}
	
	@Permission
	@RequestMapping("/addUserMenu")
	@ResponseBody
	public String addUserMenu(@ModelAttribute("userMenuForm") UserMenuForm form) {
		//清除旧菜单项
		userMenuService.deleteUserMenu(form.getUserId());
		
		int res = userMenuService.addUserMenu(form);
		
		int code = res >=1? Constant.SUCCESS_CODE: Constant.ERROR_CODE;
		ResultUtil result = new ResultUtil();
		result.setCode(code);
		result.setMsg(Constant.SUCCESS_MSG);
		return JSONObject.fromObject(result).toString();
	}
	
	@Permission
	@RequestMapping("/getUserMenu")
	@ResponseBody
	public String getUserMenu(@RequestParam("userId") String userId) {
		UserMenuForm userMenu = userMenuService.getUserMenu(userId);
		
		int code = Constant.SUCCESS_CODE;
		ResultUtil result = new ResultUtil();
		result.setCode(code);
		result.setMsg(Constant.SUCCESS_MSG);
		result.setObj(userMenu);
		return JSONObject.fromObject(result).toString();
	}
	
}
