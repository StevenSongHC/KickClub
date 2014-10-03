package com.kc.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kc.model.User;
import com.kc.service.UserService;
import com.kc.util.MD5Util;

@Controller
@RequestMapping("user")
public class UserController {
	
	@Autowired
	private UserService uService;

	/*
	 * Default page, also home page for current login user
	 * 默认用户主页
	 */
	@RequestMapping
	public String index(ModelMap model) {
		
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
		model.addAttribute("user", user);
		return "USER/homepage";
	}

	/*
	 * redirect to register page
	 * 转到注册页面
	 */
	@RequestMapping("register")
	public String register(ModelMap model) {
		return "USER/register";
	}
	
	/*
	 * try to register a new user, and return the result
	 * 尝试注册新用户，并返回结果
	 */
	@RequestMapping(value = "register/do")
	@ResponseBody
	public Map<String, Object> registerUser(String email,
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
		System.out.println(senior + " - " + fromProvince + " - " + fromCity + " - " +
						   presentProvince + " - " + presentCity + " - " +
						   college + " - " + major);
		
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
		
		result.put("userName", newbie.getName());
		
		return result;
	}

	@RequestMapping("login")
	public String login(ModelMap model) {
		return "USER/login";
	}
	
	@RequestMapping("list")
	public String listUser(ModelMap model) {
		System.out.println("yeah");
		
		return "USER/list";
	}
	
}
