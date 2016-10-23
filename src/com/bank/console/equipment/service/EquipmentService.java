package com.bank.console.equipment.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bank.console.common.util.CSVUtil;
import com.bank.console.equipment.model.Equipment;
import com.bank.console.equipment.vo.EquipmentVo;
import com.bank.console.mapper.EquipmentMapper;
import com.bank.console.system.form.UserForm;
import com.bank.console.system.vo.UserVO;

/**
 * 
 * @author zhouzhongxing
 * @since 2016年9月26日
 *
 */
@Service
public class EquipmentService {
	
	@Resource
	private EquipmentMapper equipmentMapper;
	
	/**
	 * 增加设备
	 * @param equipment
	 * @return
	 */
	public int addEquipment(Equipment equipment){
		return equipmentMapper.addEquipment(equipment);
	}
	
	/**
	 * 删除设备
	 * @param id
	 * @return
	 */
	public int deleteEquipment(String id){
		return equipmentMapper.deleteEquipment(id);
	}
	
	/**
	 * 修改设备
	 * @param equipment
	 * @return
	 */
	public int updateEquipment(Equipment equipment){
		return equipmentMapper.updateEquipment(equipment);
	}
	
	/**
	 * 获取设备详情
	 * @param id
	 * @return
	 */
	public EquipmentVo getEquipmentInfo(String id){
		return equipmentMapper.getEquipmentInfo(id);
	}
	
	/**
	 * 设备列表
	 * @param param
	 * @return
	 */
	public List<EquipmentVo> getEquipmentList(Map<String, Object> param){
		return equipmentMapper.getEquipmentList(param);
	}
	
	/**
	 * 查询数量
	 * @param param
	 * @return
	 */
	public int getEquipmentSum(Map<String, Object> param){
		return equipmentMapper.getEquipmentSum(param);
	}

	/**
	 * 创建excel
	 * @param form
	 * @param path
	 * @param fileName
	 * @return
	 */
	public File createCSVData(Map param, String path, String fileName) {
		List<EquipmentVo> eqList = this.getEquipmentList(param);
		List<Map> exportData = this.buildData(eqList);

		Map titleMap = this.buildTitle();
		File file = CSVUtil.createCSVFile(exportData, titleMap, path, fileName);
		return file;
	}
	
	/**
	 * 表头
	 * @return
	 */
	private Map buildTitle() {
		Map map = new LinkedHashMap();
	    map.put("1", "编号");
	    map.put("2", "名称");
	    map.put("3", "型号");
	    map.put("4", "所在地");
	    map.put("5", "状态");
	    map.put("6", "供应商");
	    map.put("7", "购入时间");
	    map.put("8", "价格");
	    map.put("9", "备注");
	    map.put("10", "所在部门");
	    map.put("11", "创建时间");
	    return map;
	}
	
	private List<Map> buildData(List<EquipmentVo> eqList) {
	    List exportData = new ArrayList<Map>();
	    Map row = new LinkedHashMap<String, String>();
	    
	    for(int i = 0; i < eqList.size(); i++) {
	    	EquipmentVo eq = eqList.get(i);
	    	row.put("1", eq.getId());
	    	row.put("2", eq.getName());
	    	row.put("3", eq.getType());
	    	row.put("4", eq.getLocation());
	    	row.put("5", eq.getInUse());
	    	row.put("6", eq.getCompanyId());
	    	row.put("7", eq.getBuyTimeStr());
	    	row.put("8", eq.getPrice());
	    	row.put("9", eq.getRemark());
	    	row.put("10", eq.getDeptId());
	    	row.put("11", eq.getCreateTime());
	    	exportData.add(row);
	    }
	    
	    return exportData;
	}
}
