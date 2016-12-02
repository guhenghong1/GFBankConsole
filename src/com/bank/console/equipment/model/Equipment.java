package com.bank.console.equipment.model;

import java.util.Date;

/**
 * 设备
 * @author zhouzhongxing
 * @since 2016年9月26日
 *
 */
public class Equipment {
	
	private String id;			//设备编号
	private String name; 		//设备名称
	private String type; 		//设备型号
	private String location;	//所在地
	private Integer inUse;		//设备状态，1表示在用，0表示报废
	private String companyId;	//供应商编号
	private String company;	//供应商编号
	private Date buyTime;		//购入时间
	private String price;		//价格
	private String remark;		//备注
	private String deptId;		//部门编号
	private String deptName;		//部门编号
	private Integer status;		//状态，1表示正常，0表示删除
	private Date createTime;	//创建时间
	private String createTimeStr;	//创建时间
	private Date updateTime;	//修改时间
	
	public Equipment(){
		
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public Integer getInUse() {
		return inUse;
	}

	public void setInUse(Integer inUse) {
		this.inUse = inUse;
	}

	public String getCompanyId() {
		return companyId;
	}

	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}

	public Date getBuyTime() {
		return buyTime;
	}

	public void setBuyTime(Date buyTime) {
		this.buyTime = buyTime;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getDeptId() {
		return deptId;
	}

	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
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

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

}
