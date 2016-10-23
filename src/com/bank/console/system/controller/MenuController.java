package com.bank.console.system.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bank.console.common.Constant;
import com.bank.console.common.interceptor.Permission;
import com.bank.console.common.util.ResultUtil;
import com.bank.console.system.form.MenuForm;
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
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("/init")
	public String init() {
		return "system/menu";
	}
	
	/**
	 * 新增文件
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping(value="/addMenu", method = RequestMethod.POST)
	@ResponseBody
	public String addMenu(@ModelAttribute("menuForm") MenuForm form) {
		//MultipartMenu 
		ResultUtil result = new ResultUtil();
		int res = 0;
		try {
			res = menuService.addMenu(form);
			int code = res >=1? Constant.SUCCESS_CODE: Constant.ERROR_CODE;
			result.setCode(code);
			result.setMsg(res >=1? Constant.SUCCESS_MSG : Constant.ERROR_MSG);
		} catch (Exception e) {
			result.setCode(Constant.ERROR_CODE);
			result.setMsg(Constant.ERROR_MSG);
			e.printStackTrace();
		}
		
		return JSONObject.fromObject(result).toString();
	}
	
	/**
	 * 修改文件
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping(value="/updateMenu", method = RequestMethod.POST)
	@ResponseBody
	public String updateMenu(@ModelAttribute("mMenuForm") MenuForm form) {
		//MultipartMenu 
		ResultUtil result = new ResultUtil();
		int res = 0;
		try {
			res = menuService.updateMenu(form);
			int code = res >=1? Constant.SUCCESS_CODE: Constant.ERROR_CODE;
			result.setCode(code);
			result.setMsg(res >=1? Constant.SUCCESS_MSG : Constant.ERROR_MSG);
		} catch (Exception e) {
			result.setCode(Constant.ERROR_CODE);
			result.setMsg(Constant.ERROR_MSG);
			e.printStackTrace();
		}
		
		return JSONObject.fromObject(result).toString();
	}
	
	/**
	 * 删除
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping("/deleteMenu")
	@ResponseBody
	public String deleteMenu(@RequestParam("menuId") String menuId) {
		ResultUtil result = new ResultUtil();
		int res = menuService.deleteMenu(menuId);
		
		result.setCode(res > 0 ? Constant.SUCCESS_CODE : Constant.ERROR_CODE);
		result.setMsg(res > 0 ? Constant.SUCCESS_MSG : Constant.ERROR_MSG);
		return JSONObject.fromObject(result).toString();
	}
	
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
	@RequestMapping("/getLevelMenuTree")
	@ResponseBody
	public String getLevelMenuTree() {
		List<MenuVO> menuList = menuService.getLevelMenuTree();
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
	
	/**
	 * 获取详情
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping("/getMenuInfo")
	@ResponseBody
	public String getMenuInfo(@RequestParam("menuId") String menuId) {
		ResultUtil result = new ResultUtil();
		MenuVO menu = menuService.getMenuInfo(menuId);
		
		result.setCode(Constant.SUCCESS_CODE);
		result.setMsg(Constant.SUCCESS_MSG);
		result.setObj(menu);
		return JSONObject.fromObject(result).toString();
	}
	
}
