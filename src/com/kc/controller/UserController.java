package com.kc.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("user")
public class UserController {

	@RequestMapping
	public String hello(ModelMap model) {
		System.out.println("IN");
		model.addAttribute("message", "hello there, sucker");
		return "USER/hello";
	}

	@RequestMapping("register")
	public String register(ModelMap model) {
		return "USER/register";
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
	
	@RequestMapping(value = "doRegister")
	@ResponseBody
	public Map<String, String> registerUser(String email) {
		Map<String, String> result = new HashMap<String, String>();
		System.out.println("name is" + email);
		result.put("msg", "good");
		result.put("code", "1");
		return result;
	}
	
}
