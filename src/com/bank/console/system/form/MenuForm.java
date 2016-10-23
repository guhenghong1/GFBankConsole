package com.bank.console.system.form;

import java.util.List;

import com.bank.console.dept.model.Dept;

public class MenuForm {
	private String menuId;
	private String menuName;
	private String superMenuId;
	private String remark;
	private String linkUrl;
	
	public String getMenuId() {
		return menuId;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public String getSuperMenuId() {
		return superMenuId;
	}
	public void setSuperMenuId(String superMenuId) {
		this.superMenuId = superMenuId;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getLinkUrl() {
		return linkUrl;
	}
	public void setLinkUrl(String linkUrl) {
		this.linkUrl = linkUrl;
	}
}
