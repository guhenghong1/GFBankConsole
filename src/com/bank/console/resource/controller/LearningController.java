package com.bank.console.resource.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

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
import com.bank.console.resource.form.LearningForm;
import com.bank.console.resource.service.LearningService;
import com.bank.console.resource.vo.LearningVO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/learn")
public class LearningController {
	@Autowired
	private LearningService learningService;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@Permission
	@RequestMapping("/init")
	public String init() {
		return "resource/learn";
	}
	
	/**
	 * 新增
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping(value="/addLearn", method = RequestMethod.POST)
	@ResponseBody
	public String addLearning(@ModelAttribute("LearningForm") LearningForm form) {
		//MultipartLearning 
		ResultUtil result = new ResultUtil();
		int res = 0;
		try {
			res = learningService.addLearning(form);
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
	 * 修改
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping(value="/updateLearn", method = RequestMethod.POST)
	@ResponseBody
	public String updateLearning(@ModelAttribute("mLearningForm") LearningForm form) {
		//MultipartLearning 
		ResultUtil result = new ResultUtil();
		int res = 0;
		try {
			res = learningService.updateLearning(form);
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
	 * 修改
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping(value="/updateViewCount")
	@ResponseBody
	public String updateViewCount(@RequestParam(value="id") String id) {
		//MultipartLearning 
		ResultUtil result = new ResultUtil();
		int res = 0;
		try {
			res = learningService.updateViewCount(id);
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
	 * 获取列表
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping("/getLearnList")
	@ResponseBody
	public String getLearningList(@RequestParam(value="id") String id, 
			@RequestParam(value="title") String title, 
			@RequestParam(value="pageNum", defaultValue="1") String pageNum, 
			@RequestParam(value="pageSize", defaultValue="10") String pageSize) {
		LearningForm form = new LearningForm();
		form.setId(id);
		form.setTitle(title);
		
		int total = learningService.getLearningSum(form);
		
		PageCalc calc = new PageCalc(total);
		form.setStartRow(calc.getStart(Integer.parseInt(pageNum)));
		form.setEndRow(calc.getEnd(Integer.parseInt(pageNum)));
		
		List<LearningVO> LearningList = learningService.getLearningList(form);
		JSONArray jsonArr = new JSONArray();
		jsonArr = JSONArray.fromObject(LearningList);
		
		Pager pager = new Pager();
		pager.setTotal(total);
		pager.setRows(jsonArr);
		return JSONObject.fromObject(pager).toString();
	}
	
	
	/**
	 * 获取详情
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping("/getLearnInfo")
	@ResponseBody
	public String getLearningInfo(@RequestParam("id") String id, HttpServletResponse resp) {
		ResultUtil result = new ResultUtil();
		LearningVO Learning = learningService.getLearningInfo(id);
		
		resp.setHeader("content-type", "application/msword;charset=UTF-8");
		result.setCode(Constant.SUCCESS_CODE);
		result.setMsg(Constant.SUCCESS_MSG);
		result.setObj(Learning);
		return JSONObject.fromObject(result).toString();
	}
	
	/**
	 * 删除
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping("/deleteLearn")
	@ResponseBody
	public String deleteLearning(@RequestParam("id") String id) {
		ResultUtil result = new ResultUtil();
		int res = learningService.deleteLearning(id);
		
		result.setCode(res > 0 ? Constant.SUCCESS_CODE : Constant.ERROR_CODE);
		result.setMsg(res > 0 ? Constant.SUCCESS_MSG : Constant.ERROR_MSG);
		return JSONObject.fromObject(result).toString();
	}
	
	
}
