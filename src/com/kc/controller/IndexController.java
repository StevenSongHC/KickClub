package com.kc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping
public class IndexController {

	// Redirect to the index page, load some data
	@RequestMapping("index")
	public String index(ModelMap model) {
		return "index";
	}

	@RequestMapping("about")
	public String register(ModelMap model) {
		return "about";
	}
	
}
