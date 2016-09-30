package com.bank.console.system.service;

import java.io.File;
import java.io.FileOutputStream;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.bank.console.common.ConfigProperty;
import com.bank.console.common.Constant;
import com.bank.console.common.FilePath;
import com.bank.console.common.util.FileUtil;
import com.bank.console.common.util.MD5Util;
import com.bank.console.common.util.TextpdfUtil;
import com.bank.console.mapper.UserHomeMapper;
import com.bank.console.mapper.UserMapper;
import com.bank.console.mapper.UserSchoolMapper;
import com.bank.console.system.form.UserForm;
import com.bank.console.system.model.User;
import com.bank.console.system.model.UserHome;
import com.bank.console.system.model.UserSchool;
import com.bank.console.system.vo.UserVO;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service
public class UserService {
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private UserSchoolMapper userSchoolMapper;
	@Autowired
	private UserHomeMapper userHomeMapper;
	
	public User findUser(String userId) {
		return userMapper.findUser(userId);
	}
	
	/**
	 * 新增用户
	 * @param user
	 * @return
	 */
	public int addUser(UserForm user) {
		try {
			String path = ConfigProperty.UPLOAD_FILE_PATH + File.separator + FilePath.CERT + File.separator;
			MultipartFile certFrontAttach = user.getCertFrontAttach();
			MultipartFile certBackAttach = user.getCertBackAttach();
			String certFront = FileUtil.saveFile(certFrontAttach, path);
			String certBack = FileUtil.saveFile(certBackAttach, path);
			user.setCertFront(certFront);
			user.setCertBack(certBack);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int result = userMapper.addUser(user);
		
		//添加个人简历信息
		this.addUserSchool(user);
		//添加个人家庭信息
		this.addUserHome(user);
		
		return result;
	}
	
	/**
	 * 修改用户
	 * @param user
	 * @return
	 */
	public int updateUser(UserForm user) {
		int res = userMapper.updateUser(user);
		
		String userId = user.getUserId();
		
		deleteUserSchool(userId);
		deleteUserHome(userId);
		
		//添加个人简历信息
		this.addUserSchool(user);
		//添加个人家庭信息
		this.addUserHome(user);
		
		return res;
	}
	
	/**
	 * 删除用户
	 * @param userId
	 * @return
	 */
	public int deleteUser(String userId) {
		int res = userMapper.deleteUser(userId);
		
		this.deleteUserSchool(userId);
		this.deleteUserHome(userId);
		
		return res;
	}
	
	/**
	 * 查找用户信息
	 */
	public UserVO getUserInfo(String userId) {
		UserVO userVO = userMapper.getUserInfo(userId);
		
		List<UserSchool> schoolList = userSchoolMapper.getUserSchoolList(userId);
		if(!schoolList.isEmpty()) {
			userVO.setSchoolList(schoolList);
		}
		
		List<UserHome> homeList = userHomeMapper.getUserHomeList(userId);
		if(!homeList.isEmpty()) {
			userVO.setHomeList(homeList);
		}
		
		return userVO;
	}
	
	/**
	 * 查询用户列表
	 * @param form
	 * @return
	 */
	public List<UserVO> getUserList(UserForm form) {
		return userMapper.getUserList(form);
	}
	
	/**
	 * 查询数量
	 * @param form
	 * @return
	 */
	public int getUserSum(UserForm form) {
		return userMapper.getUserSum(form);
	}
	
	/**
	 * 修改密码
	 * @param userId
	 * @param pass
	 * @return
	 */
	public int userStatus(String userId, String pass) {
		pass = MD5Util.getMD5Code(pass);
		UserVO user = this.getUserInfo(userId);
		if(user == null) {	//用户不存在
			return Constant.USER_NOT_EXIST;
		} 
		
		if(!MD5Util.getMD5Code(pass).equals(user.getPass())) { //密码错误
			return Constant.PWD_ERROR;
		} else {	//成功
			return Constant.SUCCESS_CODE;
		}
	}
	
	/**
	 * 添加用户学籍信息
	 * @param form
	 */
	public void addUserSchool(UserForm form) {
		String schoolList = form.getSchoolList();
		if(StringUtils.isEmpty(schoolList)) {
			return ;
		}
		
		String userId = form.getUserId();
		
		JSONArray schoolArr = JSONArray.fromObject(schoolList);
		for(int i = 0; i< schoolArr.size(); i++) {
			JSONObject json = schoolArr.getJSONObject(i);
			String time = json.getString("time");
			String schoolName = json.getString("schoolName");
			String remark = json.getString("remark");
			
			UserSchool school = new UserSchool();
			school.setUserId(userId);
			school.setTime(time);
			school.setSchoolName(schoolName);
			school.setRemark(remark);
			
			userSchoolMapper.addUserSchool(school);
		}
	}
	
	/**
	 * 添加用户家庭信息
	 * @param form
	 */
	public void addUserHome(UserForm form) {
		String homeList = form.getHomeList();
		if(StringUtils.isEmpty(homeList)) {
			return ;
		}
		
		String userId = form.getUserId();
		
		JSONArray homeArr = JSONArray.fromObject(homeList);
		for(int i = 0; i< homeArr.size(); i++) {
			JSONObject json = homeArr.getJSONObject(i);
			String appellation = json.getString("appellation");
			String name = json.getString("name");
			String deptName = json.getString("deptName");
			String remark = json.getString("remark");
			
			UserHome home = new UserHome();
			home.setUserId(userId);
			home.setAppellation(appellation);
			home.setName(name);
			home.setDeptName(deptName);
			home.setRemark(remark);
			
			userHomeMapper.addUserHome(home);
		}
	}
	
	/**
	 * 删除用户关联简历
	 * @param userId
	 * @return
	 */
	public int deleteUserSchool(String userId) {
		return userSchoolMapper.deleteUserSchool(userId);
	}
	
	/**
	 * 删除用户关联简历
	 * @param userId
	 * @return
	 */
	public int deleteUserHome(String userId) {
		return userHomeMapper.deleteUserHome(userId);
	}
	
	/**
	 * 生成pdf文件
	 * @param user
	 * @return
	 */
	public boolean createUserInfoPdf(UserVO user) {
		boolean bol = true;
		return bol;
	}
	
	public boolean createPdf(UserForm user, String path) {
		Boolean bol = true;
		try{
			Document doc = new Document();
			File file = new File(path);
			file.getParentFile().mkdirs();
			PdfWriter writer = PdfWriter.getInstance(doc, new FileOutputStream(path));
			doc.open();
			PdfContentByte canvas = writer.getDirectContentUnder();
			Image image = Image.getInstance("");
			image.scaleAbsolute(155.4f, 30.625f);
			image.setAbsolutePosition(35, 806-30.625f);
			canvas.addImage(image);
			float[] widths = {};
			PdfPTable table = new PdfPTable(widths);
			table.setWidthPercentage(100);
			table.setSpacingBefore(50);
			
			BaseFont baseFont = BaseFont.createFont("fonts/SIMFANG.TTF", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
			Font font = new Font(baseFont, 18, Font.BOLD);
			Paragraph title = TextpdfUtil.createParagraph("员工信息表", font);
			title.setFont(font);
//			title.add(Chunk.TABBING);
			title.setAlignment(Element.ALIGN_CENTER);
			PdfPCell cell = TextpdfUtil.createCell(title, 1, 1);
			cell.setBorder(PdfPCell.NO_BORDER);
			cell.setPaddingBottom(13);
			cell.setFixedHeight(32);
			table.addCell(cell);
			
			baseFont = BaseFont.createFont("fonts/SIMSUN.TTC,1", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
			Font bold = new Font(baseFont, 10, Font.BOLD);
			font = new Font(baseFont, 11);
			
			cell = TextpdfUtil.createCell(new Paragraph("姓 名", font), 1,  1, Element.ALIGN_CENTER, Element.ALIGN_MIDDLE);
			table.addCell(cell);
			cell = TextpdfUtil.createCell(new Paragraph(user.getRealName(), font), 1,  1, Element.ALIGN_CENTER, Element.ALIGN_MIDDLE);
			table.addCell(cell);
			
			cell = TextpdfUtil.createCell(new Paragraph("姓 名", font), 1,  1, Element.ALIGN_CENTER, Element.ALIGN_MIDDLE);
			table.addCell(cell);
			cell = TextpdfUtil.createCell(new Paragraph("\u221A男   \u25A1女", font), 1,  1, Element.ALIGN_CENTER, Element.ALIGN_MIDDLE);
			table.addCell(cell);
			
			doc.add(table);
		} catch(Exception e) {
			e.printStackTrace();
			bol = false;
		}
		return bol;
	}
}
