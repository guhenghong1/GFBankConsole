package com.bank.console.conference.controller;

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
import com.bank.console.conference.form.ConferenceForm;
import com.bank.console.conference.service.ConferenceService;
import com.bank.console.conference.vo.ConferenceVO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/conference")
public class ConferenceController {
	@Autowired
	private ConferenceService conferenceService;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@Permission
	@RequestMapping("/init")
	public String init() {
		return "meet/conference";
	}
	
	/**
	 * 新增文件
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping(value="/addConference", method = RequestMethod.POST)
	@ResponseBody
	public String addConference(@ModelAttribute("conferenceForm") ConferenceForm form) {
		//MultipartConference 
		ResultUtil result = new ResultUtil();
		int res = 0;
		try {
			Date time = DateUtil.defaultStrToDate(form.getTimeStr());
			form.setTime(time);
			
			res = conferenceService.addConference(form);
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
	@RequestMapping(value="/updateConference", method = RequestMethod.POST)
	@ResponseBody
	public String updateConference(@ModelAttribute("mConferenceForm") ConferenceForm form) {
		//MultipartConference 
		ResultUtil result = new ResultUtil();
		int res = 0;
		try {
			Date time = DateUtil.defaultStrToDate(form.getTimeStr());
			form.setTime(time);
			
			res = conferenceService.updateConference(form);
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
	 * 获取文件列表
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping("/getConferenceList")
	@ResponseBody
	public String getConferenceList(@RequestParam(value="id") String id, 
			@RequestParam(value="pageNum", defaultValue="1") String pageNum, 
			@RequestParam(value="pageSize", defaultValue="10") String pageSize) {
		ConferenceForm form = new ConferenceForm();
		form.setId(id);
		
		int total = conferenceService.getConferenceSum(form);
		
		PageCalc calc = new PageCalc(total);
		form.setStartRow(calc.getStart(Integer.parseInt(pageNum)));
		form.setEndRow(calc.getEnd(Integer.parseInt(pageNum)));
		
		List<ConferenceVO> ConferenceList = conferenceService.getConferenceList(form);
		JSONArray jsonArr = new JSONArray();
		jsonArr = JSONArray.fromObject(ConferenceList);
		
		Pager pager = new Pager();
		pager.setTotal(total);
		pager.setRows(jsonArr);
		return JSONObject.fromObject(pager).toString();
	}
	
	
	/**
	 * 获取文件详情
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping("/getConferenceInfo")
	@ResponseBody
	public String getConferenceInfo(@RequestParam("id") String id) {
		ResultUtil result = new ResultUtil();
		ConferenceVO Conference = conferenceService.getConferenceInfo(id);
		
		result.setCode(Constant.SUCCESS_CODE);
		result.setMsg(Constant.SUCCESS_MSG);
		result.setObj(Conference);
		return JSONObject.fromObject(result).toString();
	}
	
	/**
	 * 删除
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping("/deleteConference")
	@ResponseBody
	public String deleteConference(@RequestParam("id") String id) {
		ResultUtil result = new ResultUtil();
		int res = conferenceService.deleteConference(id);
		
		result.setCode(res > 0 ? Constant.SUCCESS_CODE : Constant.ERROR_CODE);
		result.setMsg(res > 0 ? Constant.SUCCESS_MSG : Constant.ERROR_MSG);
		return JSONObject.fromObject(result).toString();
	}
	
	
}
