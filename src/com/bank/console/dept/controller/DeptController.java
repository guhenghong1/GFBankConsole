package com.bank.console.dept.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bank.console.dept.service.DeptService;
import com.bank.console.dept.vo.DeptVO;

import net.sf.json.JSONArray;

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
		return "dept/dept";
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
}
