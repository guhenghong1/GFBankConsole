package com.bank.console.equipment.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bank.console.equipment.model.Equipment;
import com.bank.console.equipment.vo.EquipmentVo;
import com.bank.console.mapper.EquipmentMapper;

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

}
