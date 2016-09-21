package com.bank.console.dept.model;

import java.util.List;

import org.apache.poi.ss.formula.functions.T;

public class Tree {
	private boolean state;	//打开、关闭状态
	private List<T> children;	//子节点
	public boolean isState() {
		return state;
	}
	public void setState(boolean state) {
		this.state = state;
	}
	public List<T> getChildren() {
		return children;
	}
	public void setChildren(List<T> children) {
		this.children = children;
	}
}
