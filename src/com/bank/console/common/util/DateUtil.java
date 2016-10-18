package com.bank.console.common.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {
	public static final String defaultFormate = "yyyy年MM月dd日 HH时mm分ss秒";
	
	public static final String defaultStr2DateFormate = "yyyy-MM-dd HH:mm:ss";
	
	public static final String str2CalenderFormate = "yyyy-MM-dd";
	
	public static final String str2DayFormate = "yyyyMMdd";
	
	/**
	 * 默认转str
	 * @param date
	 * @return
	 */
	public static String defaultDateToStr(Date date) {
		SimpleDateFormat sf = new SimpleDateFormat(defaultFormate);
		return sf.format(date);
	}
	
	public static String formateDateToStr(Date date, String formate) {
		SimpleDateFormat sf = new SimpleDateFormat(formate);
		return sf.format(date);
	}
	
	public static Date defaultStrToDate(String str) {
		try {
			SimpleDateFormat sf = new SimpleDateFormat(defaultStr2DateFormate);
			return sf.parse(str);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}
	
	public static Date strToDate(String str, String formate) {
		try {
			SimpleDateFormat sf = new SimpleDateFormat(formate);
			return sf.parse(str);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}
}
