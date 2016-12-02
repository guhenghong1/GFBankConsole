package com.bank.console.common.util.encrypt;

import java.io.IOException;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class BASE64Util {
	/**
	 * base64加密
	 */
	public static String encrypt(String inStr) throws Exception {
		byte[] bytes = inStr.getBytes("UTF-8");
		BASE64Encoder encoder = new BASE64Encoder();
		return encoder.encode(bytes);
	}
	
	/**
	 * base64加密
	 */
	public static String encryptBytes(byte[] bytes) throws Exception {
		BASE64Encoder encoder = new BASE64Encoder();
		return encoder.encode(bytes);
	}
	
	/**
	 * base64解密
	 * @param inStr
	 * @return
	 * @throws Exception
	 */
	public static String decrypt(String inStr) throws Exception {
		BASE64Decoder decoder = new BASE64Decoder();
		byte[] bytes = decoder.decodeBuffer(inStr);
		return new String(bytes);
	}
	
	/**
	 * base64解密
	 * @param inStr
	 * @return
	 * @throws Exception
	 */
	public static byte[] decryptToBytes(String inStr) throws Exception {
		
		BASE64Decoder decoder = new BASE64Decoder();
		byte[] bytes = decoder.decodeBuffer(inStr);
		return bytes;
	}
	
	
	
	public static void main(String[] args) {
		try {
			String inStr = "abc123";
			String enStr = encrypt(inStr);
			System.out.println(enStr);
			String deStr = decrypt(enStr);
			System.out.println(deStr);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
