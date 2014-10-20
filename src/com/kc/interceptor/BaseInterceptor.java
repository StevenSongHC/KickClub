package com.kc.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.kc.model.User;
import com.kc.service.UserService;
import com.kc.util.CookieUtil;

public class BaseInterceptor implements HandlerInterceptor {
	
	@Autowired
	UserService uService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object handler) throws Exception {
		/////////////////////////////
		//////   AUTO LOGIN   ///////
		/////////////////////////////
		// if didn't detective a login user, then check the user cookie to auto login for user
		if (request.getSession().getAttribute("USER_SESSION") == null) {
			Cookie[] cookies = request.getCookies();
			if (cookies != null) {
				for (Cookie cookie : cookies) {
					if (cookie.getName().equals("USER_COOKIE")) {
						User user = uService.getUserByName(cookie.getValue().split(",")[1]);
						if (cookie.getValue().split(",")[2].equals(user.getPassword())) {
							request.getSession().setAttribute("USER_SESSION", user);	// add user session
							
							cookie.setValue("");										// remove the old cookie first
							cookie.setMaxAge(0);
							cookie.setPath("/");
							response.addCookie(cookie);
							response.addCookie(CookieUtil.generateUserCookie(user));	// then add the old one
						}
						if (request.getSession().getAttribute("USER_SESSION") != null)  // don't know why the heck does it run 4 times
							break;
					}	
				}
			}
		}
		
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response,
			Object handler, ModelAndView modelAndView) throws Exception {
		
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		
	}

}
