package com.bank.console.system.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bank.console.common.Constant;
import com.bank.console.common.util.ResultUtil;
import com.bank.console.system.service.MenuService;
import com.bank.console.system.service.UserMenuService;
import com.bank.console.system.vo.MenuVO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/menu")
public class MenuController {
	@Autowired
	private MenuService menuService;
	@Autowired
	private UserMenuService userMenuService;
	
	/**
	 * 获取文件列表
	 * @param form
	 * @return
	 */
	@RequestMapping("/getMenuTree")
	@ResponseBody
	public String getMenuTree() {
		List<MenuVO> menuList = menuService.getMenuTree();
		JSONArray jsonArr = new JSONArray();
		jsonArr = JSONArray.fromObject(menuList);
		
		return jsonArr.toString();
	}
	
	/**
	 * 获取文件列表
	 * @param form
	 * @return
	 */
	@RequestMapping("/getUserMenuTree")
	@ResponseBody
	public String getUserMenuTree(@RequestParam("userId") String userId) {
		ResultUtil res = new ResultUtil();
		JSONArray jsonArr = userMenuService.getUserMenuTree(userId);
		
		if(jsonArr.isEmpty()) {
			res.setCode(Constant.DATA_EMPTY_CODE);
			res.setMsg(Constant.DATA_EMPTY_MSG);
		} else {
			res.setCode(Constant.SUCCESS_CODE);
			res.setMsg(Constant.SUCCESS_MSG);
			res.setObj(jsonArr);
		}
		
		return JSONObject.fromObject(res).toString();
	}
	
}
