package com.bank.console.dept.vo;

import java.util.List;

import com.bank.console.dept.model.Dept;

public class DeptVO {
	private String deptId;		//部门编号
	private String deptName;	//部门名称
	private String superDeptId;		//父级部门编号
	private String superDeptName;	//父级部门名称
	private int isLeaf;			//是否是叶子节点 1是  0否
	private boolean status;	
	
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
	public int getIsLeaf() {
		return isLeaf;
	}
	public void setIsLeaf(int isLeaf) {
		this.isLeaf = isLeaf;
	}
	public boolean isStatus() {
		return status;
	}
	public void setStatus(boolean status) {
		this.status = status;
	}
}
