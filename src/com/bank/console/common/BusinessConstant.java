package com.bank.console.common;

import java.util.HashMap;
import java.util.Map;

public class BusinessConstant {
	//文件保密级别
	public static final Map<String, String> SECRETLEVELMAP = new HashMap<String, String>();
	//文件状态
	public static final Map<String, String> FILE_STATUS = new HashMap<String, String>();
	
	//权证类型
	public static final Map<String, String> WARRANT_TYPE = new HashMap<String, String>();
	
	//权证状态
	public static final Map<String, String> WARRANT_STATUS = new HashMap<String, String>();
	
	//设备状态
	public static final Map<String, String> inUse = new HashMap<String, String>();
	
	static {
		initSecretLevelMap();
		initWarrantType();
		initFileStatus();
		initWarrantStatus();
		initInUse();
	}
	
	private static void initFileStatus() {
		FILE_STATUS.put("1", "已阅");	
		FILE_STATUS.put("2", "董事长处理中");	
		FILE_STATUS.put("3", "已处理");	
	}
	private static void initSecretLevelMap() {
		SECRETLEVELMAP.put("0", "公开");	//对外开放
		SECRETLEVELMAP.put("1", "秘密");	//公司内部所有员工
		SECRETLEVELMAP.put("1", "机密");	//仅限于公司总经理，高层管理人员，部门经理、副经理及事件相关负责人
		SECRETLEVELMAP.put("1", "绝密");	//仅限于公司总经理，高层管理人员及事件相关负责人
	}
	
	private static void initWarrantStatus() {
		WARRANT_STATUS.put("0", "待入库");
		WARRANT_STATUS.put("1", "已入库");
		WARRANT_STATUS.put("2", "出库");
	}
	
	private static void initWarrantType() {
		WARRANT_TYPE.put("1", "他项权证");
		WARRANT_TYPE.put("2", "存单");
		WARRANT_TYPE.put("3", "承兑汇票");
		WARRANT_TYPE.put("4", "其它");
	}
	
	private static void initInUse() {
		inUse.put("0", "报废");
		inUse.put("1", "在用");
		inUse.put("2", "送修");
	}
}
