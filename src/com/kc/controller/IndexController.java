package com.kc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import com.kc.service.ProvinceService;
import com.kc.service.UserService;

@Controller
@RequestMapping
public class IndexController {
	
	@Autowired
	private UserService uService;
	@Autowired
	private ProvinceService prService;

	// Redirect to the index page, load some data
	@RequestMapping("index")
	public String index(ModelMap model) {
		return "index";
	}

	@RequestMapping("about")
	public String about(ModelMap model) {
		return "about";
	}
	
	// For loading login form
	@RequestMapping("getLoginForm")
	public String loadLogonForm(ModelMap model) {
		return "login-form";
	}

	
}
