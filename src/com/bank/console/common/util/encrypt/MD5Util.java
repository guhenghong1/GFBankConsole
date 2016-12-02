package com.bank.console.common.util.encrypt;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MD5Util {
	// 全局数组
    private final static String[] strDigits = { "0", "1", "2", "3", "4", "5",
            "6", "7", "8", "9", "a", "b", "c", "d", "e", "f" };

    // 返回形式为数字跟字符串
    private static String byteToArrayString(byte bByte) {
        int iRet = bByte;
        if (iRet < 0) {
            iRet += 256;
        }
        int iD1 = iRet / 16;
        int iD2 = iRet % 16;
        return strDigits[iD1] + strDigits[iD2];
    }

    // 返回形式只为数字
    private static String byteToNum(byte bByte) {
        int iRet = bByte;
        if (iRet < 0) {
            iRet += 256;
        }
        return String.valueOf(iRet);
    }

    // 转换字节数组为16进制字串
    private static String byteToString(byte[] bByte) {
        StringBuffer sBuffer = new StringBuffer();
        for (int i = 0; i < bByte.length; i++) {
            sBuffer.append(byteToArrayString(bByte[i]));
        }
        return sBuffer.toString();
    }

    public static String getMD5Code(String strObj) {
    	if(strObj == null) {
    		return "";
    	}
        String resultString = null;
        try {
            resultString = new String(strObj);
            MessageDigest md = MessageDigest.getInstance("MD5");
            // md.digest() 该函数返回值为存放哈希值结果的byte数组
            resultString = byteToString(md.digest(strObj.getBytes()));
        } catch (NoSuchAlgorithmException ex) {
            ex.printStackTrace();
        }
        return resultString;
    }

    /**
     * md5加密
     * @param str
     * @return
     */
    public static String md5Encode(String str) {
    	MessageDigest md5 = null;
    	byte[] byteArray = null;
    	StringBuffer hexValue = new StringBuffer();
    	try {
			md5 = MessageDigest.getInstance("MD5");
			byteArray = str.getBytes("UTF-8");
			byte[] md5Bytes = md5.digest(byteArray);
			for(int i = 0; i < md5Bytes.length; i++) {
				int val = (int)md5Bytes[i] & 0xff;
				// 如果该正数小于16(长度为1个字符)，前面拼接0占位：确保最后生成的是32位字符串。
				if(val < 16) {
					hexValue.append("0");
				}
				hexValue.append(Integer.toHexString(val));
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
    	return hexValue.toString().toUpperCase();
    }
    
    public static void main(String[] args) {
    	MD5Util getMD5 = new MD5Util();
//        System.out.println(getMD5.getMD5Code("admin123"));
        String str = md5Encode("123");
        System.out.println("str=  "+str);
    }
}
