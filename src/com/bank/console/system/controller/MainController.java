package com.bank.console.system.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bank.console.common.Constant;
import com.bank.console.common.interceptor.Permission;
import com.bank.console.common.util.MD5Util;
import com.bank.console.common.util.ResultUtil;
import com.bank.console.system.form.UserForm;
import com.bank.console.system.model.User;
import com.bank.console.system.service.UserService;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/main")
public class MainController {
	@Autowired
	private UserService userService;
	
	@RequestMapping("/login")
	@ResponseBody
	public String login(@RequestParam("userId") String userId, @RequestParam("pass") String pass, Model model, HttpSession session) {
		User user = userService.findUser(userId);
		model.addAttribute("userId", userId);
		model.addAttribute("pass", pass);
		
		ResultUtil result = new ResultUtil();
		if(user == null) {	//用户不存在
			result.setCode(Constant.USER_NOT_EXIST);
			result.setMsg(Constant.USER_NOT_EXIST_MSG);
			return JSONObject.fromObject(result).toString();
		} 
		
		if(!MD5Util.getMD5Code(pass).equals(user.getPass())) { //密码错误
			result.setCode(Constant.PWD_ERROR);
			result.setMsg(Constant.PWD_ERROR_MSG);
		} else {	//成功
			result.setCode(Constant.SUCCESS_CODE);
			result.setMsg(Constant.SUCCESS_MSG);
			
			session.setAttribute(Constant.SESSION_USER_ID, user.getUserId());
			session.setAttribute(Constant.SESSION_USER_PWD, user.getPass());
		}
		return JSONObject.fromObject(result).toString();
	}
	
	@RequestMapping("/signOut")
	@ResponseBody
	public String signOut(HttpSession session) {
		ResultUtil result = new ResultUtil();
			result.setCode(Constant.SUCCESS_CODE);
			result.setMsg(Constant.SUCCESS_MSG);
			
			session.setAttribute(Constant.SESSION_USER_ID, "");
		return JSONObject.fromObject(result).toString();
	}
	


	@RequestMapping("/updateUserPwd")
	@ResponseBody
	public String updateUserPwd(@RequestParam("userId") String userId,
			@RequestParam("oriPwd") String oriPwd,
			@RequestParam("newPwd") String newPwd) {
		ResultUtil result = new ResultUtil();
		User user = userService.findUser(userId);
		if(user == null) {	//用户不存在
			result.setCode(Constant.USER_NOT_EXIST);
			result.setMsg(Constant.USER_NOT_EXIST_MSG);
			return JSONObject.fromObject(result).toString();
		} 
		
		if (!MD5Util.getMD5Code(oriPwd).equals(user.getPass())) {	//工号已存在
			result.setCode(Constant.PWD_ERROR);
			result.setMsg(Constant.PWD_ERROR_MSG);
			return JSONObject.fromObject(result).toString();
		}
		
		UserForm userForm = new UserForm();
		userForm.setUserId(userId);
		userForm.setPass(MD5Util.getMD5Code(newPwd));
		
		int res = userService.updateUser(userForm);
		
		int code = res >=1? Constant.SUCCESS_CODE: Constant.ERROR_CODE;
		result.setCode(code);
		result.setMsg(Constant.SUCCESS_MSG);
		return JSONObject.fromObject(result).toString();
	}
	
	@RequestMapping("/index")
	@Permission
	public String login() {
		return "main";
	}
	
	@RequestMapping("/toUpdatePwd")
	@Permission
	public String toUpdatePwd() {
		return "modifyPsw";
	}
}
