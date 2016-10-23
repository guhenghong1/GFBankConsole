package com.bank.console.resource.form;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import com.bank.console.system.model.BaseForm;

public class LearningForm extends BaseForm{
	private String id;	//编号
	private String title;		//标题
	private String remark;		//备注
	private int viewCount;	//流量数
	private String attachment;	//附件
	private String createDateStr;	//创建时间
	private Date createDate;
	private String updateDateStr;	//创建时间
	private Date updateDate;
	private String startDate;
	private String endDate;
	
	private MultipartFile  fileItem;		//上传文件
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public int getViewCount() {
		return viewCount;
	}
	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
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
	public String getAttachment() {
		return attachment;
	}
	public void setAttachment(String attachment) {
		this.attachment = attachment;
	}
	public MultipartFile getFileItem() {
		return fileItem;
	}
	public void setFileItem(MultipartFile fileItem) {
		this.fileItem = fileItem;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
}
