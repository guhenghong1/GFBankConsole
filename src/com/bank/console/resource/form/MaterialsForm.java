package com.bank.console.resource.form;

import java.util.Date;

import com.bank.console.system.model.BaseForm;

/**
 * @author ghh
 *
 */
public class MaterialsForm extends BaseForm{
	private String companyId;	//公司编号
	private String company;		//公司名称
	private String type;		//公司类型
	private String scope;		//提供服务范围
	private String supplierA;	//联系人
	private String mobileA;		//联系电话
	private String supplierB;	//联系人
	private String mobileB;		//联系电话
	private String scoreLevel;	//评分
	private String remark;		//备注
	private String createDateStr;	//创建时间
	private Date createDate;		
	private String updateDateStr;
	private	Date updateDate;
	
	public String getCompanyId() {
		return companyId;
	}
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
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
	public String getSupplierA() {
		return supplierA;
	}
	public void setSupplierA(String supplierA) {
		this.supplierA = supplierA;
	}
	public String getMobileA() {
		return mobileA;
	}
	public void setMobileA(String mobileA) {
		this.mobileA = mobileA;
	}
	public String getSupplierB() {
		return supplierB;
	}
	public void setSupplierB(String supplierB) {
		this.supplierB = supplierB;
	}
	public String getMobileB() {
		return mobileB;
	}
	public void setMobileB(String mobileB) {
		this.mobileB = mobileB;
	}
	public String getScoreLevel() {
		return scoreLevel;
	}
	public void setScoreLevel(String scoreLevel) {
		this.scoreLevel = scoreLevel;
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
	public String getUpdateDateStr() {
		return updateDateStr;
	}
	public void setUpdateDateStr(String updateDateStr) {
		this.updateDateStr = updateDateStr;
	}
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
}
