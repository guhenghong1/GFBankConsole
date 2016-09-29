package com.bank.console.equipment.model;

import java.util.Date;

/**
 * 送修
 * @author zhouzhongxing
 * @since 2016年9月29日
 *
 */
public class SendRepair {
	
	private Integer id;			//编号
	private String equipmentId;	//设备编号
	private Date createTime;	//创建时间
	private Date updateTime;	//修改时间
	
	public SendRepair(){
		
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getEquipmentId() {
		return equipmentId;
	}

	public void setEquipmentId(String equipmentId) {
		this.equipmentId = equipmentId;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

}
