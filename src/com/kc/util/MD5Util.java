package com.kc.util;

import java.security.MessageDigest;

public class MD5Util {
	
	/*
	 * encrypt the password
	 * 加密密码
	 */
	public static String encryptCode(String password) {
		if (password != null) {
			try {
				MessageDigest md = MessageDigest.getInstance("MD5");
				byte[] results = md.digest(password.getBytes());
				StringBuilder resultStr = new StringBuilder();
				for (byte result : results) {
					resultStr.append(String.format("%02x", result));
				}
				return resultStr.toString().toUpperCase();
			} catch (Exception e) {
				System.out.println("加密失败");
				e.printStackTrace();
			}
		}
		return null;
	}
	
	/*
	 * authenticate the password
	 * 验证密码
	 */
	public static boolean authenticateCode(String password, String inputStr) {
		return password.equals(encryptCode(inputStr));
	}
	
}
