package com.bank.console.business.vo;

import java.util.Date;

public class WarrantVO {
	private String id;	//编号
	private String type;		//权证类型
	private Date updateDate;		//修改时间
	private String updateDateStr;		//修改时间
	private String borrower;		//借款人
	private int normLimit;	//额度
	private String propertyOwner;		//产权所有人
	private String cardId;	//权证证号
	private String deptId;	//登记部门
	private String remark;		//备注
	private String createDateStr;	//创建时间
	private Date createDate;
	private int status;		//状态 0待入库  1已入库  2出库
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	public String getUpdateDateStr() {
		return updateDateStr;
	}
	public void setUpdateDateStr(String updateDateStr) {
		this.updateDateStr = updateDateStr;
	}
	public String getBorrower() {
		return borrower;
	}
	public void setBorrower(String borrower) {
		this.borrower = borrower;
	}
	public int getNormLimit() {
		return normLimit;
	}
	public void setNormLimit(int normLimit) {
		this.normLimit = normLimit;
	}
	public String getPropertyOwner() {
		return propertyOwner;
	}
	public void setPropertyOwner(String propertyOwner) {
		this.propertyOwner = propertyOwner;
	}
	public String getCardId() {
		return cardId;
	}
	public void setCardId(String cardId) {
		this.cardId = cardId;
	}
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getCreateDateStr() {
		return createDateStr;
	}
	public void setCreateDateStr(String createDateStr) {
		this.createDateStr = createDateStr;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
}
