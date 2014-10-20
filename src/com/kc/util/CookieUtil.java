package com.kc.util;

import javax.servlet.http.Cookie;

import com.kc.model.User;


public class CookieUtil {
	
	public final static int COOKIE_MAX_AGE = 60;			// cookie 最大生命值
	
	// 生成包含用户信息的 cookie
	public static Cookie generateUserCookie(User user) {
		// cookie contains id, name, encrypted password
		Cookie cookie = new Cookie("USER_COOKIE", user.getId()+","+user.getName()+","+user.getPassword());
		cookie.setMaxAge(COOKIE_MAX_AGE);
		cookie.setPath("/");
		System.out.println("cookie: "+cookie.getValue());
		return cookie;
	}

}
