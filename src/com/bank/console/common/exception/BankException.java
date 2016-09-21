package com.bank.console.common.exception;

public class BankException extends RuntimeException{
	private String code;	//异常码
	private String msg;		//异常信息
	
	public BankException() {
		super();
	}
	
	public BankException(String msg) {
		super();
		this.msg = msg;
	}
	
	public BankException(String code, String msg) {
		super();
		this.code = code;
		this.msg = msg;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
	
}
