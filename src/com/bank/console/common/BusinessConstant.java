package com.bank.console.common;

import java.util.HashMap;
import java.util.Map;

public class BusinessConstant {
	//文件保密级别
	public static final Map<String, String> SECRETLEVELMAP = new HashMap<String, String>();
	
	//权证类型
	public static final Map<String, String> WARRANT_TYPE = new HashMap<String, String>();
	
	static {
		initSecretLevelMap();
		initWarrantType();
	}
	
	private static void initSecretLevelMap() {
		SECRETLEVELMAP.put("0", "公开");	//对外开放
		SECRETLEVELMAP.put("1", "秘密");	//公司内部所有员工
		SECRETLEVELMAP.put("1", "机密");	//仅限于公司总经理，高层管理人员，部门经理、副经理及事件相关负责人
		SECRETLEVELMAP.put("1", "绝密");	//仅限于公司总经理，高层管理人员及事件相关负责人
	}
	
	private static void initWarrantType() {
		WARRANT_TYPE.put("0", "他项权证");
		WARRANT_TYPE.put("1", "存单");
		WARRANT_TYPE.put("2", "承兑汇票");
		WARRANT_TYPE.put("3", "其它");
	}
}
