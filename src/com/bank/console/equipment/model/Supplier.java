package com.bank.console.equipment.model;

import java.util.Date;

/**
 * 供应商
 * @author zhouzhongxing
 * @since 2016年9月26日
 *
 */
public class Supplier {
	
	private String id; 			//供应商编号
	private String name;		//供应商名称
	private String type;		//供应商类型
	private String scope;		//供应范围
	private String contact1;	//联系人1
	private String contact2;	//联系人2
	private String grade;		//供应商评级
	private String remark;		//备注
	private Integer status;		//状态，1表示正常，0表示删除
	private Date createTime;	//创建时间
	private Date updateTime;	//修改时间
	
	public Supplier(){
		
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

	public String getScope() {
		return scope;
	}

	public void setScope(String scope) {
		this.scope = scope;
	}

	public String getContact1() {
		return contact1;
	}

	public void setContact1(String contact1) {
		this.contact1 = contact1;
	}

	public String getContact2() {
		return contact2;
	}

	public void setContact2(String contact2) {
		this.contact2 = contact2;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
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

}
