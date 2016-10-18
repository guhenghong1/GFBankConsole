package com.bank.console.business.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bank.console.business.form.WarrantForm;
import com.bank.console.business.model.Dictionary;
import com.bank.console.business.service.DictionaryService;
import com.bank.console.business.service.WarrantService;
import com.bank.console.business.vo.WarrantVO;
import com.bank.console.common.BusinessConstant;
import com.bank.console.common.Constant;
import com.bank.console.common.PageCalc;
import com.bank.console.common.Pager;
import com.bank.console.common.interceptor.Permission;
import com.bank.console.common.util.ResultUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/warrant")
public class WarrantController {
	@Autowired
	private WarrantService warrantService;
	@Autowired
	private DictionaryService dictionaryService;
	
	private static final String ADD = "add";
	private static final String UPDATE = "update";
	private static final String UPDATE_STATUS = "updateStatus";
	/**
	 * 跳转页面
	 * @return
	 */
	@Permission
	@RequestMapping("/init")
	public String init(@RequestParam("menu")String menu, HttpServletRequest req) {
		req.setAttribute("menu", menu);
		String returnUrl = "";
		if(ADD.equals(menu)) {
			returnUrl = "business/warrant";
		} else if(UPDATE.equals(menu)) {
			returnUrl = "business/updateWarrant";
		} else if(UPDATE_STATUS.equals(menu)) {
			returnUrl = "business/updateStatusWarrant";
		}
		return returnUrl;
	}
	
	/**
	 * 新增文件
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping(value="/addWarrant", method = RequestMethod.POST)
	@ResponseBody
	public String addWarrant(@ModelAttribute("WarrantForm") WarrantForm form) {
		//MultipartWarrant 
		ResultUtil result = new ResultUtil();
		int res = 0;
		try {
			res = warrantService.addWarrant(form);
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
	@RequestMapping(value="/updateWarrant", method = RequestMethod.POST)
	@ResponseBody
	public String updateWarrant(@ModelAttribute("mwarrantForm") WarrantForm form) {
		//MultipartWarrant 
		ResultUtil result = new ResultUtil();
		int res = 0;
		try {
			res = warrantService.updateWarrant(form);
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
	@RequestMapping("/getWarrantList")
	@ResponseBody
	public String getWarrantList(@RequestParam(value="id") String id,
			@RequestParam(value="borrower") String borrower,
			@RequestParam(value="status") int status,
			@RequestParam(value="pageNum", defaultValue="1") String pageNum, 
			@RequestParam(value="pageSize", defaultValue="10") String pageSize) {
		WarrantForm form = new WarrantForm();
		form.setId(id);
		form.setBorrower(borrower);
		form.setStatus(status);
		
		int total = warrantService.getWarrantSum(form);
		
		PageCalc calc = new PageCalc(total);
		form.setStartRow(calc.getStart(Integer.parseInt(pageNum)));
		form.setEndRow(calc.getEnd(Integer.parseInt(pageNum)));
		
		List<WarrantVO> warrantList = warrantService.getWarrantList(form);
		this.buildWarrant(warrantList);
		JSONArray jsonArr = new JSONArray();
		jsonArr = JSONArray.fromObject(warrantList);
		
		Pager pager = new Pager();
		pager.setTotal(total);
		pager.setRows(jsonArr);
		return JSONObject.fromObject(pager).toString();
	}
	
	private List<WarrantVO> buildWarrant(List<WarrantVO> warrantList) {
		for(WarrantVO wa : warrantList) {
			wa.setType(BusinessConstant.WARRANT_TYPE.get(wa.getType()));
		}
		return warrantList;
	}
	
	/**
	 * 获取文件详情
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping("/getWarrantInfo")
	@ResponseBody
	public String getWarrantInfo(@RequestParam("id") String id) {
		ResultUtil result = new ResultUtil();
		WarrantVO Warrant = warrantService.getWarrantInfo(id);
		
		result.setCode(Constant.SUCCESS_CODE);
		result.setMsg(Constant.SUCCESS_MSG);
		result.setObj(Warrant);
		return JSONObject.fromObject(result).toString();
	}
	
	/**
	 * 删除
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping("/deleteWarrant")
	@ResponseBody
	public String deleteWarrant(@RequestParam("id") String id) {
		ResultUtil result = new ResultUtil();
		int res = warrantService.deleteWarrant(id);
		
		result.setCode(res > 0 ? Constant.SUCCESS_CODE : Constant.ERROR_CODE);
		result.setMsg(res > 0 ? Constant.SUCCESS_MSG : Constant.ERROR_MSG);
		return JSONArray.fromObject(result).toString();
	}
	
	/**
	 * 
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping("/getCardList")
	@ResponseBody
	public String getCardList() {
		List<Dictionary> dicList = dictionaryService.getDictionaryList("", WarrantService.CARD);
		return JSONArray.fromObject(dicList).toString();
	}
	
	/**
	 * 
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping("/getDeptList")
	@ResponseBody
	public String getDeptList() {
		List<Dictionary> dicList = dictionaryService.getDictionaryList("", WarrantService.DEPT);
		return JSONArray.fromObject(dicList).toString();
	}
	
	/**
	 * 
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping("/getRemarkList")
	@ResponseBody
	public String getRemarkList() {
		List<Dictionary> dicList = dictionaryService.getDictionaryList("", WarrantService.REMARK);
		return JSONArray.fromObject(dicList).toString();
	}
	
	
}
