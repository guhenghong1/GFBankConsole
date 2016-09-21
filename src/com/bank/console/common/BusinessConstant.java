package com.bank.console.common;

import java.util.HashMap;
import java.util.Map;

public class BusinessConstant {
	//文件保密级别
	private static final Map<String, String> SECRETLEVELMAP = new HashMap<String, String>();
	
	static {
		
	}
	
	public static void initSecretLevelMap() {
		SECRETLEVELMAP.put("0", "公开");	//对外开放
		SECRETLEVELMAP.put("1", "秘密");	//公司内部所有员工
		SECRETLEVELMAP.put("1", "机密");	//仅限于公司总经理，高层管理人员，部门经理、副经理及事件相关负责人
		SECRETLEVELMAP.put("1", "绝密");	//仅限于公司总经理，高层管理人员及事件相关负责人
	}
}
