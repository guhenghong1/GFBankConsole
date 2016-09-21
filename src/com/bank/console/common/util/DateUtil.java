package com.bank.console.common.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {
	private static final String defaultFormate = "yyyy年MM月dd日 HH时mm分ss秒";
	
	public static String DefaultDateToStr(Date date) {
		SimpleDateFormat sf = new SimpleDateFormat(defaultFormate);
		return sf.format(date);
	}
	
	public static String FormateDateToStr(Date date, String formate) {
		SimpleDateFormat sf = new SimpleDateFormat(formate);
		return sf.format(date);
	}
}
