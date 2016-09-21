package com.water.works.user.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.water.works.common.util.Constant;
import com.water.works.common.util.Pager;
import com.water.works.common.util.ResultUtil;
import com.water.works.user.model.User;
import com.water.works.user.service.UserService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("user")
public class UserController {
	@Autowired
	private UserService userService;

	@RequestMapping("/login")
	public String login(@RequestParam("name") String name, @RequestParam("pass") String pass, Model model) {
		// User user = userService.findUser();
		model.addAttribute("name", name);
		model.addAttribute("pass", pass);
		return "main";
	}

	@RequestMapping("/init")
	public String init() {
		return "user/user";
	}

	@RequestMapping("/getUserList")
	@ResponseBody
	public String getUserList() {
		List<User> userList = userService.getUserList();
		JSONArray jsonArr = new JSONArray();
		jsonArr = JSONArray.fromObject(userList);

		Pager pager = new Pager();
		pager.setTotal(20);
		pager.setRows(jsonArr);
		JSONObject json = new JSONObject();
		json.put("total", 20);
		json.put("rows", jsonArr);
		return JSONObject.fromObject(pager).toString();
	}
	
	@RequestMapping("/getUserInfo")
	@ResponseBody
	public String getUserInfo(@RequestParam("userId") String userId) {
		User user = userService.getUserInfo(Integer.parseInt(userId));
		return JSONObject.fromObject(user).toString();
	}

	@RequestMapping("/updateUser")
	@ResponseBody
	public String updateUser(@RequestParam("userId") String userId, @RequestParam("userName") String userName,
			@RequestParam("realName") String realName, @RequestParam("role") int role,
			@RequestParam("customer") String customer, @RequestParam("mobile") String mobile,
			@RequestParam("email") String email) {
		User user = new User();
		user.setUserId(Integer.parseInt(userId));
		user.setUserName(userName);
		user.setRealName(realName);
		user.setRole(role);
		user.setCustomer(customer);
		user.setMobile(mobile);
		user.setEmail(email);
		
		int res = userService.updateUser(user);
		
		int code = res >=1? Constant.SUCCESS_CODE: Constant.ERROR_CODE;
		ResultUtil result = new ResultUtil();
		result.setCode(code);
		result.setMessage(Constant.SUCCESS_MSG);
		return JSONObject.fromObject(result).toString();
	}
	
	@RequestMapping("/deleteUser")
	@ResponseBody
	public String deleteUser(@RequestParam("userId") String userId) {
		int res = userService.deleteUser(Integer.parseInt(userId));
		
		int code = res >=1? Constant.SUCCESS_CODE: Constant.ERROR_CODE;
		ResultUtil result = new ResultUtil();
		result.setCode(code);
		result.setMessage(Constant.SUCCESS_MSG);
		return JSONObject.fromObject(result).toString();
	}
	
	@RequestMapping("/addUser")
	@ResponseBody
	public String addUser(@RequestParam("userName") String userName,
			@RequestParam("realName") String realName, @RequestParam("role") int role,
			@RequestParam("customer") String customer, @RequestParam("mobile") String mobile,
			@RequestParam("email") String email) {
		User user = new User();
		user.setUserName(userName);
		user.setRealName(realName);
		user.setRole(role);
		user.setCustomer(customer);
		user.setMobile(mobile);
		user.setEmail(email);
		
		int res = userService.addUser(user);
		
		int code = res >=1? Constant.SUCCESS_CODE: Constant.ERROR_CODE;
		ResultUtil result = new ResultUtil();
		result.setCode(code);
		result.setMessage(Constant.SUCCESS_MSG);
		return JSONObject.fromObject(result).toString();
	}
}
