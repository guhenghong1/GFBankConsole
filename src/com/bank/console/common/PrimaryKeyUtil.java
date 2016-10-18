package com.bank.console.common;

import org.springframework.beans.factory.annotation.Autowired;

import com.bank.console.mapper.DeptMapper;

public class PrimaryKeyUtil {
	@Autowired
	private DeptMapper deptMapper;
	
	public static final String TB_DEPT = "tb_dept";
	public static final String TB_RECEVICE_FILE = "tb_receivce_file";
	public static final String TB_SEND_FILE = "tb_send_file";
	
	public static String getMaxId(String tbName) {
		int id = 0;
		if(TB_DEPT.equals(tbName)) {
		} else if(TB_SEND_FILE.equals(tbName)) {
			
		}
		
		return "";
	}
	
}
