package com.kc.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kc.model.User;
import com.kc.util.MD5Util;

@Controller
@RequestMapping("user")
public class UserController {

	@RequestMapping
	public String hello(ModelMap model) {
		System.out.println("IN");
		model.addAttribute("message", "hello there, sucker");
		return "USER/hello";
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
											String fromProvince,
											String fromCity,
											String presentProvince,
											String presentCity,
											String college,
											String major) {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println(senior + " - " + fromProvince + " - " + fromCity + " - " +
						   presentProvince + " - " + presentCity + " - " +
						   college + " - " + major);
		System.out.println("p:" + MD5Util.encryptCode(password));
		User newbie = new User();
		result.put("code", 1);
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
