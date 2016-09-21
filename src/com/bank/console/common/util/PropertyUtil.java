package com.bank.console.common.util;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

public class PropertyUtil {
	private static Map<String, String> configMap = new HashMap<String, String>();
	static{
		Properties pro = new Properties();
		InputStream in = PropertyUtil.class.getResourceAsStream("/config.properties");
		try {
			Object.class.getClassLoader();
			pro.load(in);
			Enumeration<?> allName = pro.propertyNames();
			while(allName.hasMoreElements()) {
				String name = (String)allName.nextElement();
				String value = pro.getProperty(name);
				System.out.println("key:  "+name+"  value:  "+value);
				configMap.put(name, value);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 获取配置
	 * @param key
	 * @return
	 */
	public static String getProperty(String key) {
		return configMap.get(key);
	}
	
	public static void main(String[] args) {
		System.out.println("111");
	}
}
