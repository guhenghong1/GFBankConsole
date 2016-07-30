package com.water.works.common.util;

import net.sf.json.JSONArray;

public class Pager {
	private int pageNum;
	private int pageSize;
	private int total;
	private int totalPage;
	private JSONArray rows;
	
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public JSONArray getRows() {
		return rows;
	}
	public void setRows(JSONArray rows) {
		this.rows = rows;
	}
	
}
