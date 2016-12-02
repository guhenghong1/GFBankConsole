package com.bank.console.common.util.encrypt;

import java.io.UnsupportedEncodingException;
import java.security.SecureRandom;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;

/**
 * 对称加密算法
 * @author ghh
 *
 */
public class DESUtil {
	/**
	 * 对称加密并base64加密
	 * @param key 密钥要求key至少长度为8个字符   
	 * @return
	 * @throws Exception 
	 */
	public static String encrypt(String key, String inStr, SecureRandom random) throws Exception {
			byte[] bytes = key.getBytes("UTF-8");
			DESKeySpec keySpec = new DESKeySpec(bytes);
			//密钥工厂
			SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
			//生成密钥
			SecretKey secretKey = keyFactory.generateSecret(keySpec);
			
			//加密过程
			Cipher cipher = Cipher.getInstance("DES");
			cipher.init(Cipher.ENCRYPT_MODE, secretKey, random);
			
			byte[] inBytes = inStr.getBytes("UTF-8");
			byte[] cipherBytes = cipher.doFinal(inBytes);
			
			//用base64加密
			return BASE64Util.encryptBytes(cipherBytes);
	}
	
	/**
	 * 对称加密
	 * @param key 密钥要求key至少长度为8个字符   
	 * @return
	 * @throws Exception 
	 */
	public static byte[] encryptBytes(String key, String inStr) throws Exception {
		byte[] bytes = key.getBytes("UTF-8");
		DESKeySpec keySpec = new DESKeySpec(bytes);
		//密钥工厂
		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
		//生成密钥
		SecretKey secretKey = keyFactory.generateSecret(keySpec);
		
		SecureRandom random = new SecureRandom();
		//加密过程
		Cipher cipher = Cipher.getInstance("DES");
		cipher.init(Cipher.ENCRYPT_MODE, secretKey, random);
		
		byte[] inBytes = inStr.getBytes("UTF-8");
		byte[] cipherBytes = cipher.doFinal(inBytes);
		
		//解密
		cipher.init(Cipher.DECRYPT_MODE, secretKey, random);
		byte[] outBytes = cipher.doFinal(cipherBytes);
		String outStr = new String(outBytes);
		System.out.println(outStr);
		
		return cipherBytes;
	}
	
	/**
	 * 解密且传入的经过了base64加密
	 * @param key
	 * @param inStr
	 * @param base64Decoder 是否是base64加密
	 * @return
	 * @throws Exception
	 */
	public static String decoder(String key, String inStr, SecureRandom random) throws Exception {
		byte[] bytes = key.getBytes("UTF-8");
		DESKeySpec keySpec = new DESKeySpec(bytes);
		//密钥工厂
		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
		//生成密钥
		SecretKey secretKey = keyFactory.generateSecret(keySpec);
		
		//解密
		Cipher cipher = Cipher.getInstance("DES");
		cipher.init(Cipher.ENCRYPT_MODE, secretKey, new SecureRandom());
		
		byte[] inStrBytes = {};
		//如果是base64加密过得需先解密
		String str = BASE64Util.encrypt(inStr);
		inStrBytes = str.getBytes("UTF-8");
		byte[] cipherBytes = cipher.doFinal(inStrBytes);
		return new String(cipherBytes);
	}
	
	/**
	 * 解密
	 * @param key
	 * @param inBytes
	 * @param base64Decoder 是否是base64加密
	 * @return
	 * @throws Exception
	 */
	public static String decoderBytes(String key, byte[] inBytes) throws Exception {
		byte[] bytes = key.getBytes("UTF-8");
		DESKeySpec keySpec = new DESKeySpec(bytes);
		//密钥工厂
		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
		//生成密钥
		SecretKey secretKey = keyFactory.generateSecret(keySpec);
		
		//解密
		Cipher cipher = Cipher.getInstance("DES");
		cipher.init(Cipher.ENCRYPT_MODE, secretKey, new SecureRandom());
		
		byte[] cipherBytes = cipher.doFinal(inBytes);
		return new String(cipherBytes);
	}
	
	public static void main(String[] args) {
		String key = "12345678";
		String inStr = "admin123";
		SecureRandom random = new SecureRandom();
		try {
			//加密
			String enStr = encrypt(key, inStr, random);
			System.out.println(enStr);
			
			//解密
			String decStr = decoder(key, enStr, random);
			System.out.println("decStr=  "+decStr);
			
			byte[] enBytes = encryptBytes(key, inStr);
			String outStr = decoderBytes(key, enBytes);
			System.out.println("outStr=" +outStr);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
