package com.kc.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.kc.model.User;
import com.kc.service.UserService;
import com.kc.util.CookieUtil;
import com.kc.util.MD5Util;

@Controller
@SessionAttributes("USER_SESSION")
@RequestMapping("user")
public class UserController {
	
	@Autowired
	private UserService uService;

	/*
	 * Default page, also home page for current login user
	 * 默认用户主页
	 */
	@RequestMapping
	public String index(HttpSession session) {
		User currentUser = (User) session.getAttribute("USER_SESSION");
		
		// if no login, redirect to login page
		if (currentUser == null)
			return "redirect:/user/login";
		// else redirect to current user's homepage
		return "redirect:/user/" + currentUser.getName();
	}
	
	/*
	 * Default page, also home page for current login user
	 * 默认用户主页
	 */
	@RequestMapping("{userName}")
	public String homepage(ModelMap model,
						   @PathVariable String userName) {
		User user = uService.getUserByName(userName);
		
		if (user == null)
			return "STATIC/404";
		
		model.addAttribute("user", user);
		return "USER/homepage";
	}

	/*
	 * Go to register page
	 * 转到注册页面
	 */
	@RequestMapping("register")
	public String register() {
		return "USER/register";
	}
	
	/*
	 * Try to register a new user, and return the result
	 * 尝试注册新用户，并返回结果
	 */
	@RequestMapping(value = "register/do")
	@ResponseBody
	public Map<String, Object> registerUser(ModelMap model,
											String email,
											String name,
											String password,
											String senior,
											int fromProvince,
											int fromCity,
											int presentProvince,
											int presentCity,
											int college,
											String major,
											SessionStatus sessionStatus,
											HttpSession session,
											HttpServletRequest request,
											HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		// logout first
		User currentUser = (User) session.getAttribute("USER_SESSION");
		if (currentUser != null) {
			sessionStatus.setComplete();
			CookieUtil.removeCookie(request, response, "USER_COOKIE");
		}
		
		User newbie = new User();
		newbie.setEmail(email);
		newbie.setName(name);
		newbie.setPassword(MD5Util.encryptCode(password));
		newbie.setSenior(senior);
		newbie.setFromProvince(fromProvince);
		newbie.setFromCity(fromCity);
		newbie.setPresentProvince(presentProvince);
		newbie.setPresentCity(presentCity);
		newbie.setCollege(college);
		newbie.setCollegeMajor(major);
		
		java.sql.Date currentDate = new java.sql.Date(new java.util.Date().getTime());
		newbie.setJoinDate(currentDate);
		newbie.setLastLoginDate(currentDate);
		
		uService.addUser(newbie);
		
		if (newbie.getId() != 0)
			result.put("code", 1);
		
		// login
		model.addAttribute("USER_SESSION", newbie);
		response.addCookie(CookieUtil.generateUserCookie(newbie));
		
		result.put("userName", newbie.getName());
		
		return result;
	}
	
	/*
	 * Go to login page
	 * 转到登陆界面
	 */
	@RequestMapping("login")
	public String login(HttpSession session) {
		User loginUser = (User) session.getAttribute("USER_SESSION");
		if (loginUser == null)
			return "USER/login";
		else						// redirect login user to the index page
			return "redirect:../";
	}

	/*
	 * Complete login action
	 * 完成登陆动作，会通过Ajax返回登陆结果
	 */
	@RequestMapping("login/do")
	@ResponseBody
	public Map<String, Object> loginUser(ModelMap model,
										 String email,
										 String password,
										 boolean rememberme,
										 HttpSession session,
										 HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		User loginUser = uService.getUserByEmail(email);
		
		if (loginUser == null)														// not such user existed
			result.put("statusCode", 0);
		else if (!MD5Util.authenticateInputPassword(loginUser.getPassword(), password))		// fail to valid the password
			result.put("statusCode", -1);
		else {																		// login succeed
			result.put("statusCode", 1);
			model.addAttribute("USER_SESSION", loginUser);							// add user session
			if (rememberme)	{														// remember me function on
				response.addCookie(CookieUtil.generateUserCookie(loginUser));
			}
		}
		
		return result;
	}
	
	/*
	 * Logout action
	 * 用户注销动作
	 */
	@RequestMapping("logout")
	@ResponseBody
	public Map<String, Object> logoutUser(SessionStatus sessionStatus,
										  HttpServletRequest request,
										  HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		sessionStatus.setComplete();									// remove session
		CookieUtil.removeCookie(request, response, "USER_COOKIE");		// remove cookie
		
		return result;
	}
	
	/*
	 * Go to user setting page
	 * 转到用户设置界面
	 */
	@RequestMapping("setting")
	public String setting(HttpSession session) {
		User currentUser = (User) session.getAttribute("USER_SESSION");
	
		// if no login, redirect to login page
		if (currentUser == null)
			return "redirect:/user/login";
		
			return "USER/setting";
	}
	
	@RequestMapping("list")
	public String listUser(ModelMap model) {
		return "USER/list";
	}
	
}
