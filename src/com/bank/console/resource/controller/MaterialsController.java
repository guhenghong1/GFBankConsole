package com.bank.console.resource.controller;

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
import com.bank.console.common.util.ResultUtil;
import com.bank.console.resource.form.MaterialsForm;
import com.bank.console.resource.service.MaterialsService;
import com.bank.console.resource.vo.MaterialsVO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/materials")
public class MaterialsController {
	@Autowired
	private MaterialsService materialsService;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@Permission
	@RequestMapping("/init")
	public String init() {
		return "resource/materials";
	}
	
	/**
	 * 新增文件
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping(value="/addMaterials", method = RequestMethod.POST)
	@ResponseBody
	public String addMaterials(@ModelAttribute("materialsForm") MaterialsForm form) {
		//MultipartMaterials 
		ResultUtil result = new ResultUtil();
		int res = 0;
		try {
			res = materialsService.addMaterials(form);
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
	@RequestMapping(value="/updateMaterials", method = RequestMethod.POST)
	@ResponseBody
	public String updateMaterials(@ModelAttribute("mMaterialsForm") MaterialsForm form) {
		//MultipartMaterials 
		ResultUtil result = new ResultUtil();
		int res = 0;
		try {
			res = materialsService.updateMaterials(form);
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
	@RequestMapping("/getMaterialsList")
	@ResponseBody
	public String getMaterialsList(@RequestParam(value="companyId") String companyId, 
			@RequestParam(value="pageNum", defaultValue="1") String pageNum, 
			@RequestParam(value="pageSize", defaultValue="10") String pageSize) {
		MaterialsForm form = new MaterialsForm();
		form.setCompanyId(companyId);
		
		int total = materialsService.getMaterialsSum(form);
		
		PageCalc calc = new PageCalc(total);
		form.setStartRow(calc.getStart(Integer.parseInt(pageNum)));
		form.setEndRow(calc.getEnd(Integer.parseInt(pageNum)));
		
		List<MaterialsVO> MaterialsList = materialsService.getMaterialsList(form);
		JSONArray jsonArr = new JSONArray();
		jsonArr = JSONArray.fromObject(MaterialsList);
		
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
	@RequestMapping("/getMaterialsInfo")
	@ResponseBody
	public String getMaterialsInfo(@RequestParam("companyId") String companyId) {
		ResultUtil result = new ResultUtil();
		MaterialsVO Materials = materialsService.getMaterialsInfo(companyId);
		
		result.setCode(Constant.SUCCESS_CODE);
		result.setMsg(Constant.SUCCESS_MSG);
		result.setObj(Materials);
		return JSONObject.fromObject(result).toString();
	}
	
	/**
	 * 删除
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping("/deleteMaterials")
	@ResponseBody
	public String deleteMaterials(@RequestParam("companyId") String companyId) {
		ResultUtil result = new ResultUtil();
		int res = materialsService.deleteMaterials(companyId);
		
		result.setCode(res > 0 ? Constant.SUCCESS_CODE : Constant.ERROR_CODE);
		result.setMsg(res > 0 ? Constant.SUCCESS_MSG : Constant.ERROR_MSG);
		return JSONObject.fromObject(result).toString();
	}
	
	@RequestMapping("/getMaterialsBox")
	@ResponseBody
	public String getMaterialsBox() {
		List<MaterialsVO> materialsList = materialsService.getAllMaterialsList();

		JSONArray jsonArr = new JSONArray();
		for(MaterialsVO vo : materialsList){
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("id", vo.getCompanyId());
			jsonObject.put("text", vo.getCompany());
			jsonArr.add(jsonObject);
		}	
		return jsonArr.toString();
	}
	
}
