package com.bank.console.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.bank.console.equipment.model.Equipment;
import com.bank.console.equipment.vo.EquipmentVo;

/**
 * 
 * @author zhouzhongxing
 * @since 2016年9月26日
 *
 */
@Repository
public interface EquipmentMapper {
	
	/**
	 * 增加设备
	 * @param equipment
	 * @return
	 */
	public int addEquipment(Equipment equipment);
	
	/**
	 * 删除设备
	 * @param id
	 * @return
	 */
	public int deleteEquipment(String id);
	
	/**
	 * 修改设备
	 * @param equipment
	 * @return
	 */
	public int updateEquipment(Equipment equipment);
	
	/**
	 * 获取设备详情
	 * @param id
	 * @return
	 */
	public EquipmentVo getEquipmentInfo(String id);
	
	/**
	 * 设备列表
	 * @param param
	 * @return
	 */
	public List<EquipmentVo> getEquipmentList(Map<String, Object> param);
	
	/**
	 * 查询数量
	 * @param param
	 * @return
	 */
	public int getEquipmentSum(Map<String, Object> param);

}
