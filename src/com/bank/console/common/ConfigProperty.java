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
	
	//分页大小
	public static final int LIST_PAGE_SIZE=Integer.parseInt(PropertyUtil.getProperty("LIST_PAGE_SIZE"));
	
}
