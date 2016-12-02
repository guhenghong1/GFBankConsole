package com.bank.console.common;

import java.util.HashMap;
import java.util.Map;

public class UserConstant {
	//性别
	public static final Map<String, String> SEX = new HashMap<String, String>();
	//角色
	public static final Map<String, String> ROLE = new HashMap<String, String>();
	//职务
	public static final Map<String, String> POSITION = new HashMap<String, String>();
	//当前状态
	public static final Map<String, String> STATUS = new HashMap<String, String>();
	//政治面貌
	public static final Map<String, String> politicsStatus = new HashMap<String, String>();
	//学历
	public static final Map<String, String> eduLevel = new HashMap<String, String>();
	
	static{
		SEX.put("0", "女");
		SEX.put("1", "男");
		
		ROLE.put("1", "普通用户");
		ROLE.put("2", "管理员");
		
		POSITION.put("0", "实习生");
		POSITION.put("1", "客户经理");
		POSITION.put("2", "部门经理");
		
		STATUS.put("0", "试用");
		STATUS.put("1", "转正");
		
		politicsStatus.put("0", "群众");
		politicsStatus.put("1", "团员");
		politicsStatus.put("2", "党员");
		
		eduLevel.put("0", "大专");
		eduLevel.put("1", "本科");
		eduLevel.put("2", "研究生");
		eduLevel.put("3", "博士");
	}
}
