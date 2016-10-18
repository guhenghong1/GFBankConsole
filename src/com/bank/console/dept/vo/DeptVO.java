package com.bank.console.dept.vo;

import java.util.List;

import com.bank.console.dept.model.Dept;

public class DeptVO {
	private String deptId;		//部门编号
	private String deptName;	//部门名称
	private String superDeptId;		//父级部门编号
	private String superDeptName;	//父级部门名称
	private int isSalesDept;			//是否是营业部门 1是  0否
	private String address;			//地址
	private String level;	//机构等级
	private String remark;			//备注
	
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getSuperDeptId() {
		return superDeptId;
	}
	public void setSuperDeptId(String superDeptId) {
		this.superDeptId = superDeptId;
	}
	public String getSuperDeptName() {
		return superDeptName;
	}
	public void setSuperDeptName(String superDeptName) {
		this.superDeptName = superDeptName;
	}
	public int getIsSalesDept() {
		return isSalesDept;
	}
	public void setIsSalesDept(int isSalesDept) {
		this.isSalesDept = isSalesDept;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
}
