package com.bank.console.equipment.controller;

import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bank.console.common.ConfigProperty;
import com.bank.console.common.Constant;
import com.bank.console.common.FilePath;
import com.bank.console.common.PageCalc;
import com.bank.console.common.Pager;
import com.bank.console.common.interceptor.Permission;
import com.bank.console.common.util.DateUtil;
import com.bank.console.common.util.ResultUtil;
import com.bank.console.equipment.model.Equipment;
import com.bank.console.equipment.service.EquipmentService;
import com.bank.console.equipment.vo.EquipmentVo;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 
 * @author zhouzhongxing
 * @since 2016年9月26日
 *
 */
@Controller
@Scope("prototype")
@RequestMapping("/equipment")
public class EquipmentController {
	
	@Resource
	private EquipmentService equipmentService;
	
	@Permission
	@RequestMapping("/init")
	public String init() {
		return "equipment/equipment";
	}
	
	@Permission
	@RequestMapping("/getEquipmentList")
	@ResponseBody
	public String getEquipmentList(@RequestParam("id") String id,
			@RequestParam("name") String name, 			
			@RequestParam(value="pageNum", defaultValue="1") String pageNum,
			@RequestParam(value="pageSize", defaultValue="10") String pageSize) {
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("id", id); 
		param.put("name", name); 
		
		int total = equipmentService.getEquipmentSum(param);
		
		PageCalc calc = new PageCalc(total);
		param.put("startRow", calc.getStart(Integer.parseInt(pageNum)));
		param.put("endRow", calc.getEnd(Integer.parseInt(pageNum)));

		List<EquipmentVo> userList = equipmentService.getEquipmentList(param);
		
		JSONArray jsonArr = new JSONArray();
		jsonArr = JSONArray.fromObject(userList);
		
		Pager pager = new Pager();
		pager.setTotal(total);
		pager.setRows(jsonArr);
		
		return JSONObject.fromObject(pager).toString();
	}
	
	@RequestMapping("/getEquipmentInfo")
	@ResponseBody
	public String getEquipmentInfo(String id) {
		EquipmentVo equipment = equipmentService.getEquipmentInfo(id);
		return JSONObject.fromObject(equipment).toString();
	}

	@Permission
	@RequestMapping("/updateEquipment")
	@ResponseBody
	public String updateEquipment(Equipment equipment, String buyTimeStr) {
		if(StringUtils.isNotEmpty(buyTimeStr)){
			equipment.setBuyTime(DateUtil.strToDate(buyTimeStr, "yyyy-MM-dd"));
		}
		int res = equipmentService.updateEquipment(equipment);
		
		int code = res >=1? Constant.SUCCESS_CODE: Constant.ERROR_CODE;
		ResultUtil result = new ResultUtil();
		result.setCode(code);
		result.setMsg(Constant.SUCCESS_MSG);
		return JSONObject.fromObject(result).toString();
	}
	
	@Permission
	@RequestMapping("/deleteEquipment")
	@ResponseBody
	public String deleteEquipment(String id) {
		int res = equipmentService.deleteEquipment(id);
		
		int code = res >=1? Constant.SUCCESS_CODE: Constant.ERROR_CODE;
		ResultUtil result = new ResultUtil();
		result.setCode(code);
		result.setMsg(Constant.SUCCESS_MSG);
		return JSONObject.fromObject(result).toString();
	}
	
	@Permission
	@RequestMapping("/addEquipment")
	@ResponseBody
	public String addEquipment(Equipment equipment, String buyTimeStr) {
		if(StringUtils.isNotEmpty(buyTimeStr)){
			equipment.setBuyTime(DateUtil.strToDate(buyTimeStr, "yyyy-MM-dd"));
		}
		int res = equipmentService.addEquipment(equipment);
		
		int code = res >=1? Constant.SUCCESS_CODE: Constant.ERROR_CODE;
		ResultUtil result = new ResultUtil();
		result.setCode(code);
		result.setMsg(Constant.SUCCESS_MSG);
		return JSONObject.fromObject(result).toString();
	}

	@Permission
	@RequestMapping("/createCSV")
	@ResponseBody
	public String createCSV(@RequestParam("id") String id,
			@RequestParam("name") String name, 			
			@RequestParam(value="pageNum", defaultValue="1") String pageNum,
			@RequestParam(value="pageSize", defaultValue="10") String pageSize) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("id", id); 
		param.put("name", name); 
		param.put("startRow", 1);
		param.put("endRow", 1000);
		
		String path = ConfigProperty.EXPORT_FILE_PATH + File.separator + FilePath.EXPORT_EQUIPMENT + File.separator 
				+ DateUtil.formateDateToStr(new Date(), DateUtil.str2DayFormate)+File.separator;
		String fileName = "user-"+DateUtil.formateDateToStr(new Date(), DateUtil.str2DayFormate);
		path = path.replace("\\", "/");
		File file = equipmentService.createCSVData(param, path, fileName);
		
		return file.getPath();
	}
}
