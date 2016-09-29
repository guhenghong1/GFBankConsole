package com.bank.console.equipment.vo;

import com.bank.console.equipment.model.Equipment;

/**
 * 
 * @author zhouzhongxing
 * @since 2016年9月26日
 *
 */
public class EquipmentVo extends Equipment {
	
	private String buyTimeStr; //购入时间字符串
	
	public EquipmentVo(){
		
	}

	public String getBuyTimeStr() {
		return buyTimeStr;
	}

	public void setBuyTimeStr(String buyTimeStr) {
		this.buyTimeStr = buyTimeStr;
	}

}
