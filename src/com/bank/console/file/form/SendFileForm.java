package com.bank.console.file.form;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import com.bank.console.system.model.BaseForm;

public class SendFileForm extends BaseForm{
	private String fileId;		//文件编号
	private String fileNo;		//文件字号
	private Date createDate; 	//创建时间
	private String createDateStr; 	//创建时间
	private String deptId;		//部门id
	private String deptName;	//部门
	private String fileTitle;	//文件标题
	private String keyWords; 	//关键词
	private String secretLevel;	//保密级别
	private String author;	//拟稿人
	private String checkAuthor;		//审核人
	private String signAuthor;		//签发人
	private String attachment;	//附件
	
	private String startDate;
	private String endDate;
	
	private MultipartFile  fileItem;		//上传文件

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public String getFileNo() {
		return fileNo;
	}

	public void setFileNo(String fileNo) {
		this.fileNo = fileNo;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getCreateDateStr() {
		return createDateStr;
	}

	public void setCreateDateStr(String createDateStr) {
		this.createDateStr = createDateStr;
	}

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

	public String getFileTitle() {
		return fileTitle;
	}

	public void setFileTitle(String fileTitle) {
		this.fileTitle = fileTitle;
	}

	public String getKeyWords() {
		return keyWords;
	}

	public void setKeyWords(String keyWords) {
		this.keyWords = keyWords;
	}

	public String getSecretLevel() {
		return secretLevel;
	}

	public void setSecretLevel(String secretLevel) {
		this.secretLevel = secretLevel;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getCheckAuthor() {
		return checkAuthor;
	}

	public void setCheckAuthor(String checkAuthor) {
		this.checkAuthor = checkAuthor;
	}

	public String getSignAuthor() {
		return signAuthor;
	}

	public void setSignAuthor(String signAuthor) {
		this.signAuthor = signAuthor;
	}

	public String getAttachment() {
		return attachment;
	}

	public void setAttachment(String attachment) {
		this.attachment = attachment;
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

	public MultipartFile getFileItem() {
		return fileItem;
	}

	public void setFileItem(MultipartFile fileItem) {
		this.fileItem = fileItem;
	}
	
}
