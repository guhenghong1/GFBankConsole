package com.bank.console.common.util.encrypt;

import java.io.UnsupportedEncodingException;
import java.security.Key;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.SecureRandom;
import java.security.Signature;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;

import javax.crypto.Cipher;
import javax.crypto.NoSuchPaddingException;

import org.apache.commons.lang3.StringUtils;

import sun.misc.BASE64Encoder;

public class RSAUtil {
	//加密算法
	private static final String RSA = "RSA";
	//具体加密算法
	private static final String RSA_MODE = "RSA/ECB/PKCS1Padding";
	//加密位数
	private static final int DEFAULT_KEY_SIZE = 1024;
	//数字签名算法
	private static final String SIGN_MODE = "SHA1WithRSA";
	
	//公钥
	private static final String PUBLIC_KEY = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCwX1x1k65aLbqpa3DRKFx665RDQBqs8LxQ8Aqm" +
			"DDgorsY6v0mfQT2ScwdlvZ0kziE7L6R/YSIqiI7T2jyINEL7/I5nKqPgWwWQswkqDQQLdN24v7cm/J8Imo/Ga5/6ZwlcMkAoawyvB9TguvhOUd" +
			"qtvcKR5g01GdPeK0bZ9w896QIDAQAB";
	//私钥
	private static final String PRIVATE_KEY = "MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBALBfXHWTrlotuqlrcNEoXHrrlENA" +
			"GqzwvFDwCqYMOCiuxjq/SZ9BPZJzB2W9nSTOITsvpH9hIiqIjtPaPIg0Qvv8jmcqo+BbBZCzCSoN" +
			"BAt03bi/tyb8nwiaj8Zrn/pnCVwyQChrDK8H1OC6+E5R2q29wpHmDTUZ094rRtn3Dz3pAgMBAAEC" +
			"gYA+fqvOZbPj9Ewt+AoTss+CJrN0WOSa3vp7W3MKf03u7G8FJf66VW2x1NyMKnHiNsADrtAE6rAm" +
			"jhi97JiCUrJg69b2Gd3YkhFV1IxQlvazvCy+Aj6XJdePEkaP+p6D0Q8+8zJG7g7+bgBn2cNGdDk4" +
			"HKEDWRc8qNpHvkegd9LgAQJBAPAu2t8H9YBn2Ye1TnQTJqEMi62PofQQAZC4MHeucaRCsLItttgA" +
			"k9geE+DDp0jG08QgRKT0dt0yBfdACg7JogECQQC7/MBXeLOrK3EJISJ9aSiG/xP9zCMc/U1DaeTT" +
			"7JzZ79Vi/8ojQ7S9eU9PEeyljmQQVMJOaEBMHyMYJIv2FMvpAkEA7Ui8/t60EhmG9OWQDmjlHvJw" +
			"BBYEoEQ356uwZmy25NrmCgHTw+4+IaMFbGafG+0iRX7DklvaGolTD4P668UUAQJAH3R9YqWJurx8" +
			"H4Dx2nY8F8qat77uqS0hPoR7i5Jt9HGTDQur8RalKYcg5CQlqtYWnDzyflgnWhVjs+h5muWD8QJB" +
			"AIaPcPGQh2+O2vUraepHjvP3uZcyG4cnGJ0PZdxSBHVCWVVL5Rw2hupY/fs7vvTubANfQQeAw8sn" +
			"1+uNtAb2auI=";
	
	
	public static String encrypt(String key, String inStr) throws Exception {
		//创建密钥对KeyPair
		KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance(RSA);
		keyPairGenerator.initialize(1024);
		KeyPair keyPair = keyPairGenerator.generateKeyPair();
		
		//获取公钥/私钥对
		PublicKey publicKey = keyPair.getPublic();
		PrivateKey privateKey = keyPair.getPrivate();
		
		//私钥加密
		Cipher cipher = Cipher.getInstance(RSA);
		cipher.init(Cipher.ENCRYPT_MODE, privateKey, new SecureRandom());
		
		byte[] bytes = cipher.doFinal(inStr.getBytes("UTF-8"));
		
		return BASE64Util.encryptBytes(bytes);
	}
	
	/**
	 * 生成公钥
	 * @param key base64加密后的key
	 * @return
	 * @throws Exception
	 */
	public static PublicKey getPublicKey(String key) throws Exception {
		//base64解密
		byte[] keyBytes = BASE64Util.decryptToBytes(key);
		
		//生成公钥
		X509EncodedKeySpec keySpec = new X509EncodedKeySpec(keyBytes);
		KeyFactory keyFactory = KeyFactory.getInstance(RSA);
		PublicKey publicKey = keyFactory.generatePublic(keySpec);
		
		return publicKey;
	}
	
	/**
	 * 生成私钥
	 * @param key
	 * @return
	 * @throws Exception
	 */
	public static PrivateKey getPrivateKey(String key) throws Exception {
		byte[] keyBytes = BASE64Util.decryptToBytes(key);
		
		//创建私钥
		PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(keyBytes);
		KeyFactory keyFactory = KeyFactory.getInstance(RSA);
		
		return keyFactory.generatePrivate(keySpec);
	}
	
	/**
	 * base64加密
	 * @param key
	 * @return
	 */
	public static String encryptKey(Key key) {
		byte[] bytes = key.getEncoded();
		return new BASE64Encoder().encode(bytes);
	}
	
	/**
	 * 公钥加密
	 * @param key
	 * @param inStr
	 * @return
	 * @throws Exception
	 */
	public static String encryptByPublicKey(PublicKey publicKey, String inStr) throws Exception {
		Cipher cipher = Cipher.getInstance(RSA_MODE);
		cipher.init(Cipher.ENCRYPT_MODE, publicKey, new SecureRandom());
		byte[] bytes = cipher.doFinal(inStr.getBytes("UTF-8"));
		
		return BASE64Util.encryptBytes(bytes);
	}
	
	/**
	 * 解密
	 * @param privateKey
	 * @param inStr
	 * @return
	 * @throws Exception
	 */
	public static String decryptByPrivateKey(PrivateKey privateKey, String inStr) throws Exception {
		//base64解密
		byte[] inBytes = BASE64Util.decryptToBytes(inStr);
		
		Cipher cipher = Cipher.getInstance(RSA_MODE);
		cipher.init(Cipher.DECRYPT_MODE, privateKey, new SecureRandom());
		byte[] bytes = cipher.doFinal(inBytes);
		
		return new String(bytes);
	}
	
	/**
	 * 私钥进行数字签名
	 * @param privateKey
	 * @param data
	 * @param charset
	 * @return
	 * @throws Exception
	 */
	public static String sign(String privateKeyStr, String data, String charset) throws Exception {
		if(StringUtils.isEmpty(charset)) {
			charset = "UTF-8";
		}
		byte[] bytes = data.getBytes(charset);

		//获取私钥
		PrivateKey privateKey = getPrivateKey(privateKeyStr);
		
		Signature sign = Signature.getInstance(SIGN_MODE);
		sign.initSign(privateKey);
		sign.update(bytes);
		byte[] datas = sign.sign();
		
		return  BASE64Util.encryptBytes(datas);
		
	}
	
	/**
	 * 验证数字签名
	 * @param publicKey
	 * @param data
	 * @param charset
	 * @param sign
	 * @return
	 * @throws Exception
	 */
	public static boolean verifySign(String publicKeyStr, String data, String charset, String sign) throws Exception {
		//传入的数据
		if(StringUtils.isEmpty(charset)) {
			charset = "UTF-8";
		}
		byte[] bytes = data.getBytes(charset);
		
		//获取公钥
		PublicKey publicKey = getPublicKey(publicKeyStr);
		
		//初始化验签
		Signature signature = Signature.getInstance(SIGN_MODE);
		signature.initVerify(publicKey);
		signature.update(bytes);
		
		//解密签名数据
		byte[] signBytes = BASE64Util.decryptToBytes(sign);
		
		return signature.verify(signBytes);
	}
	
	public static void test() throws Exception {
			KeyPairGenerator keyPairGen = KeyPairGenerator.getInstance(RSA);
			keyPairGen.initialize(DEFAULT_KEY_SIZE);
			
			KeyPair keyPair = keyPairGen.generateKeyPair();
			PublicKey publicKey = keyPair.getPublic();
			PrivateKey privateKey = keyPair.getPrivate();
			
			//公钥字符串
			String publicKeyStr = encryptKey(publicKey);
			
			//私钥字符串
			String privateKeyStr = encryptKey(privateKey);
			
			KeyPairGenerator keyPairGen1 = KeyPairGenerator.getInstance(RSA);
			keyPairGen1.initialize(DEFAULT_KEY_SIZE);
			
			KeyPair keyPair1 = keyPairGen1.generateKeyPair();
			PublicKey publicKey1 = keyPair1.getPublic();
			PrivateKey privateKey1 = keyPair1.getPrivate();
			
			//公钥字符串
			String publicKeyStr1 = encryptKey(publicKey1);
			System.out.println("公钥字符串=  "+publicKeyStr.equals(publicKeyStr1));
			
			//私钥字符串
			String privateKeyStr1 = encryptKey(privateKey1);
			System.out.println("私钥字符串=  "+privateKeyStr.equals(privateKeyStr1));
	}
	public static void main(String[] args) {
		try {
			//test();
			//创建密钥对
			KeyPairGenerator keyPairGen = KeyPairGenerator.getInstance(RSA);
			keyPairGen.initialize(DEFAULT_KEY_SIZE);
			
			KeyPair keyPair = keyPairGen.generateKeyPair();
			PublicKey publicKey = keyPair.getPublic();
			PrivateKey privateKey = keyPair.getPrivate();
			
			//公钥字符串
			String publicKeyStr = encryptKey(publicKey);
//			System.out.println("公钥字符串=  "+publicKeyStr);
			
			//私钥字符串
			String privateKeyStr = encryptKey(privateKey);
//			System.out.println("私钥字符串=  "+privateKeyStr);
		
			
			String inStr = "加密数据：abc123。";
			//获取公钥
			publicKey = getPublicKey(publicKeyStr);
			String enStr = encryptByPublicKey(publicKey, inStr);
//			System.out.println("加密数据="+enStr);
			
			//获取私钥
			privateKey = getPrivateKey(privateKeyStr);
			String outStr = decryptByPrivateKey(privateKey, enStr);
//			System.out.println("解密数据= "+outStr);
			
			//数字签名
			String signStr = sign(PRIVATE_KEY, inStr, "");
			System.out.println("签名文件："+signStr);
			//验证签名
			boolean bol = verifySign(PUBLIC_KEY, inStr, "", signStr);
			System.out.println("验证结果："+bol);  
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
}
