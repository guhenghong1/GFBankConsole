package com.bank.console.dept.model;

import java.util.List;


public class Tree {
	private boolean state;	//打开、关闭状态
	private List<Tree> children;	//子节点
	public boolean isState() {
		return state;
	}
	public void setState(boolean state) {
		this.state = state;
	}
	public List<Tree> getChildren() {
		return children;
	}
	public void setChildren(List<Tree> children) {
		this.children = children;
	}
}
