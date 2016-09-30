package com.bank.console.conference.vo;

import java.util.Date;

public class ConferenceVO {
	private String id;	//公司编号
	private String name;		//公司名称
	private Date time;		//公司类型
	private String timeStr;		//公司类型
	private String place;		//提供服务范围
	private String persons;	//联系人
	private String emphasis;		//联系电话
	private String content;	//联系人
	private String remark;		//备注
	private String createDateStr;	//创建时间
	private Date createDate;
	
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
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public String getTimeStr() {
		return timeStr;
	}
	public void setTimeStr(String timeStr) {
		this.timeStr = timeStr;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public String getPersons() {
		return persons;
	}
	public void setPersons(String persons) {
		this.persons = persons;
	}
	public String getEmphasis() {
		return emphasis;
	}
	public void setEmphasis(String emphasis) {
		this.emphasis = emphasis;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
	
}
