package com.kc.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kc.model.User;
import com.kc.service.UserService;
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
	public String index(ModelMap model,
						HttpSession session) {
		User currentUser = (User) session.getAttribute("USER_SESSION");
		
		// no login
		if (currentUser == null)
			return "redirect:user/login";
		// login
		model.put("user", currentUser);
		return "USER/homepage";
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
	public String register(ModelMap model) {
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
											String major) {
		Map<String, Object> result = new HashMap<String, Object>();
		
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
		
		model.addAttribute("USER_SESSION", newbie);
		
		result.put("userName", newbie.getName());
		
		return result;
	}
	
	@RequestMapping("login")
	public String login(ModelMap model) {
		return "USER/login";
	}

	@RequestMapping("login/do")
	@ResponseBody
	public Map<String, Object> loginUser(ModelMap model,
										 String email,
										 String password,
										 HttpSession session) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		User loginUser = uService.getUserByEmail(email);
		
		if (loginUser == null)														// not such user existed
			result.put("statusCode", 0);
		else if (!MD5Util.authenticateCode(loginUser.getPassword(), password))		// fail to valid the password
			result.put("statusCode", -1);
		else {																		// login succeed
			result.put("statusCode", 1);
			model.addAttribute("USER_SESSION", loginUser);
		}
		
		return result;
	}
	
	@RequestMapping("list")
	public String listUser(ModelMap model) {
		return "USER/list";
	}
	
}
