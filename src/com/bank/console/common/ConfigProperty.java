package com.bank.console.common;

import java.io.IOException;
import java.io.InputStream;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import com.bank.console.common.util.PropertyUtil;

public class ConfigProperty {
	//读取配置属性
	public static final String UPLOAD_FILE_PATH=PropertyUtil.getProperty("UPLOAD_FILE_PATH");
	//读取配置属性
	public static final String EXPORT_FILE_PATH=PropertyUtil.getProperty("EXPORT_FILE_PATH");
	
	//分页大小
	public static final int LIST_PAGE_SIZE=Integer.parseInt(PropertyUtil.getProperty("LIST_PAGE_SIZE"));
	
	//菜单根id
	public static final String MENU_ROOT_ID=PropertyUtil.getProperty("MENU_ROOT_ID");
	
	//部门根id
	public static final String DEPT_ROOT_ID=PropertyUtil.getProperty("DEPT_ROOT_ID");
	
}
