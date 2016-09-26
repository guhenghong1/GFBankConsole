package com.bank.console.customer.model;

import java.util.Date;

/**
 * 客户
 * @author zhouzhongxing
 * @since 2016年9月24日
 *
 */
public class Customer {
	
	private String  id;			//客户编号
	private String  manager;	//客户经理
	private String  name;		//客户名称
	private Integer	type;		//客户类型
	private Integer	grade;		//客户等级
	private String  cardNo;		//证件号码
	private String  account;	//客户账号
	private Date    birthday;	//生日
	private String  hobby;		//爱好
	private String  contact;	//联系方式
	private String  remark;		//备注
	private Integer	status;		//状态，1表正常，0表示删除
	private Date    createTime;	//创建时间
	private Date    updateTime;	//修改时间
	
	public Customer(){
		
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getManager() {
		return manager;
	}

	public void setManager(String manager) {
		this.manager = manager;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getGrade() {
		return grade;
	}

	public void setGrade(Integer grade) {
		this.grade = grade;
	}

	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getHobby() {
		return hobby;
	}

	public void setHobby(String hobby) {
		this.hobby = hobby;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
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
