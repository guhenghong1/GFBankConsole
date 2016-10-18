package com.bank.console.common.util;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;

public class StringUtil {
	
	/**
	 * 字符串转成list
	 * @param str
	 * @param f
	 * @return
	 */
	public static List<String> str2List(String str, String f) {
		if(StringUtils.isEmpty(str)) {
			return new ArrayList<String>();
		}
		
		List<String> list = new ArrayList<String>();
		String[] strArr = str.split(f);
	
		for(int i= 0; i<strArr.length; i++) {
			list.add(strArr[i]);
		}
		return list;
	}
	
	/**
	 * list转成String
	 * @param list
	 * @param c
	 * @return
	 */
	public static String list2Str(List<String> list, String c) {
		if(list.isEmpty()) {
			return "";
		}
		
		String str = "";
		for(String s : list) {
			str = str + (StringUtils.isEmpty(str)? "":c) + s;
		}
		
		return str;
	}
}
