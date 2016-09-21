package com.bank.console.common;

public class Constant {
	public static final int SUCCESS_CODE = 1;	//成功
	public static final int ERROR_CODE = 0;		//失败
	
	//用户登入状态
	public static final int USER_NOT_EXIST = -1;	//用户不存在
	public static final int USER_ID_IS_EXISTED = 2;	//用户工号已存在
	public static final int PWD_ERROR = 3;	//密码错误
	
	public static final String SUCCESS_MSG = "success";
	public static final String ERROR_MSG = "error";
	
	public static final String USER_NOT_EXIST_MSG = "用户不存在";
	public static final String USER_ID_IS_EXISTED_MSG = "工号已存在";
	public static final String PWD_ERROR_MSG = "密码错误";
	
	//session key
	public static final String SESSION_USER_ID = "sessionUserId";	//用户id
	public static final String SESSION_USER_PWD = "sessionUserPwd";	//用户密码
	public static final String SESSION_USER = "sessionUser";	//用户信息
	
}
