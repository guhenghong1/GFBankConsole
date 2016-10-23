package com.bank.console.system.form;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import com.bank.console.system.model.BaseForm;

public class UserForm extends BaseForm{
	private String userId;		//用户工号
	private String pass;			//密码
	private String realName;	//用户真实姓名
	private String deptId;		//部门编号
	private String deptName;		//部门
	private String roleId;		//角色id
	private String roleName;		//角色
	private String phone;		//座机号码
	private String mobile;		//手机号码
	private String email;		//邮箱
	private Date birthday;		//生日
	private String birthdayStr;		//生日
	private int sex;			//性别
	private String position;	//职位
	private String positionSalary;		//岗位工资
	private String levelSalary;			//等级工资
	private String performanceSalary;	//绩效工资/情亲工资
	private String status;		//职位状态
	private String isDeleted;		//用户状态
	private String interest;	//爱好特长
	private Date entryDate;		//入职时间
	private String entryDateStr;		//入职时间
	private String nativePlace;		//籍贯
	private String nation;		//民族
	private String politicsStatus;		//政治面貌
	private String certId;		//身份证号
	private String school;		//学校
	private String eduLevel;	//学历
	private String homeAddress;		//家庭住址
	private String major;		//专业
	private String remark;		//其他备注
	private String infoPdf;		//用户信息pdf
	private String createDate;	//创建时间
	private String updateDate;	//修改时间
	
	private String firstDay;	//第一天
	private String lastDay;		//最后一天
	
	private String  certFront;		//身份证正面
	private String  certBack;		//身份证反面
	private String  headPhoto;		//员工头像
	
	private MultipartFile  certFrontAttach;		//上传文件
	private MultipartFile  certBackAttach;		//上传文件
	private MultipartFile  headPhotoAttach;		//头像
	
	private String schoolList;	//用户毕业学校
	private String homeList;	//用户家庭信息
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getRoleId() {
		return roleId;
	}
	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	public String getBirthdayStr() {
		return birthdayStr;
	}
	public void setBirthdayStr(String birthdayStr) {
		this.birthdayStr = birthdayStr;
	}
	public int getSex() {
		return sex;
	}
	public void setSex(int sex) {
		this.sex = sex;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getPositionSalary() {
		return positionSalary;
	}
	public void setPositionSalary(String positionSalary) {
		this.positionSalary = positionSalary;
	}
	public String getLevelSalary() {
		return levelSalary;
	}
	public void setLevelSalary(String levelSalary) {
		this.levelSalary = levelSalary;
	}
	public String getPerformanceSalary() {
		return performanceSalary;
	}
	public void setPerformanceSalary(String performanceSalary) {
		this.performanceSalary = performanceSalary;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getInterest() {
		return interest;
	}
	public void setInterest(String interest) {
		this.interest = interest;
	}
	public Date getEntryDate() {
		return entryDate;
	}
	public void setEntryDate(Date entryDate) {
		this.entryDate = entryDate;
	}
	public String getEntryDateStr() {
		return entryDateStr;
	}
	public void setEntryDateStr(String entryDateStr) {
		this.entryDateStr = entryDateStr;
	}
	public String getNativePlace() {
		return nativePlace;
	}
	public void setNativePlace(String nativePlace) {
		this.nativePlace = nativePlace;
	}
	public String getNation() {
		return nation;
	}
	public void setNation(String nation) {
		this.nation = nation;
	}
	public String getPoliticsStatus() {
		return politicsStatus;
	}
	public void setPoliticsStatus(String politicsStatus) {
		this.politicsStatus = politicsStatus;
	}
	public String getCertId() {
		return certId;
	}
	public void setCertId(String certId) {
		this.certId = certId;
	}
	public String getSchool() {
		return school;
	}
	public void setSchool(String school) {
		this.school = school;
	}
	public String getEduLevel() {
		return eduLevel;
	}
	public void setEduLevel(String eduLevel) {
		this.eduLevel = eduLevel;
	}
	public String getHomeAddress() {
		return homeAddress;
	}
	public void setHomeAddress(String homeAddress) {
		this.homeAddress = homeAddress;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public String getCertFront() {
		return certFront;
	}
	public void setCertFront(String certFront) {
		this.certFront = certFront;
	}
	public String getCertBack() {
		return certBack;
	}
	public void setCertBack(String certBack) {
		this.certBack = certBack;
	}
	public MultipartFile getCertFrontAttach() {
		return certFrontAttach;
	}
	public void setCertFrontAttach(MultipartFile certFrontAttach) {
		this.certFrontAttach = certFrontAttach;
	}
	public MultipartFile getCertBackAttach() {
		return certBackAttach;
	}
	public void setCertBackAttach(MultipartFile certBackAttach) {
		this.certBackAttach = certBackAttach;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getInfoPdf() {
		return infoPdf;
	}
	public void setInfoPdf(String infoPdf) {
		this.infoPdf = infoPdf;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	public String getIsDeleted() {
		return isDeleted;
	}
	public void setIsDeleted(String isDeleted) {
		this.isDeleted = isDeleted;
	}
	public String getSchoolList() {
		return schoolList;
	}
	public void setSchoolList(String schoolList) {
		this.schoolList = schoolList;
	}
	public String getHomeList() {
		return homeList;
	}
	public void setHomeList(String homeList) {
		this.homeList = homeList;
	}
	public String getFirstDay() {
		return firstDay;
	}
	public void setFirstDay(String firstDay) {
		this.firstDay = firstDay;
	}
	public String getLastDay() {
		return lastDay;
	}
	public void setLastDay(String lastDay) {
		this.lastDay = lastDay;
	}
	public String getHeadPhoto() {
		return headPhoto;
	}
	public void setHeadPhoto(String headPhoto) {
		this.headPhoto = headPhoto;
	}
	public MultipartFile getHeadPhotoAttach() {
		return headPhotoAttach;
	}
	public void setHeadPhotoAttach(MultipartFile headPhotoAttach) {
		this.headPhotoAttach = headPhotoAttach;
	}
}
