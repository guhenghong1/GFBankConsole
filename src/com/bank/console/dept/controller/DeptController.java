package com.bank.console.dept.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bank.console.common.Constant;
import com.bank.console.common.PageCalc;
import com.bank.console.common.Pager;
import com.bank.console.common.interceptor.Permission;
import com.bank.console.common.util.DateUtil;
import com.bank.console.common.util.ResultUtil;
import com.bank.console.dept.form.DeptForm;
import com.bank.console.dept.service.DeptService;
import com.bank.console.dept.vo.DeptVO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/dept")
public class DeptController {
	@Autowired
	private DeptService deptService;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("/init")
	public String init() {
		return "dept/org";
	}
	
	/**
	 * 获取文件列表
	 * @param form
	 * @return
	 */
	@RequestMapping("/getDeptTree")
	@ResponseBody
	public String getDeptTree() {
		List<DeptVO> deptList = deptService.getDeptTree();
		JSONArray jsonArr = new JSONArray();
		jsonArr = JSONArray.fromObject(deptList);
		
		return jsonArr.toString();
	}
	
	/**
	 * 获取机构列表
	 * @param form
	 * @return
	 */
	@RequestMapping("/getOrgTree")
	@ResponseBody
	public String getOrgTree() {
		List<DeptVO> deptList = deptService.getOrgTree();
		JSONArray jsonArr = new JSONArray();
		jsonArr = JSONArray.fromObject(deptList);
		
		return jsonArr.toString();
	}
	
	/**
	 * 新增文件
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping(value="/addDept", method = RequestMethod.POST)
	@ResponseBody
	public String addDept(@ModelAttribute("orgForm") DeptForm form) {
		//MultipartDept 
		ResultUtil result = new ResultUtil();
		int res = 0;
		try {
			res = deptService.addDept(form);
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
	@RequestMapping(value="/updateDept", method = RequestMethod.POST)
	@ResponseBody
	public String updateDept(@ModelAttribute("mDeptForm") DeptForm form) {
		//MultipartDept 
		ResultUtil result = new ResultUtil();
		int res = 0;
		try {
			res = deptService.updateDept(form);
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
	 * 获取文件详情
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping("/getDeptInfo")
	@ResponseBody
	public String getDeptInfo(@RequestParam("deptId") String deptId) {
		ResultUtil result = new ResultUtil();
		DeptVO Dept = deptService.getDeptInfo(deptId);
		
		result.setCode(Constant.SUCCESS_CODE);
		result.setMsg(Constant.SUCCESS_MSG);
		result.setObj(Dept);
		return JSONObject.fromObject(result).toString();
	}
	
	/**
	 * 删除
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping("/deleteDept")
	@ResponseBody
	public String deleteDept(@RequestParam("deptId") String deptId) {
		ResultUtil result = new ResultUtil();
		int res = deptService.deleteDept(deptId);
		
		result.setCode(res > 0 ? Constant.SUCCESS_CODE : Constant.ERROR_CODE);
		result.setMsg(res > 0 ? Constant.SUCCESS_MSG : Constant.ERROR_MSG);
		return JSONObject.fromObject(result).toString();
	}
	
}
