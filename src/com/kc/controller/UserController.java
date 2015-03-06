package com.kc.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.IncorrectUpdateSemanticsDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.kc.model.User;
import com.kc.service.CityService;
import com.kc.service.CollegeService;
import com.kc.service.ProvinceService;
import com.kc.service.UserService;
import com.kc.util.CookieUtil;
import com.kc.util.MD5Util;

@Controller
@SessionAttributes("USER_SESSION")
@RequestMapping("user")
public class UserController {
	
	@Autowired
	private UserService uService;
	@Autowired
	private ProvinceService prService;
	@Autowired
	private CityService ctService;
	@Autowired
	private CollegeService clgService;

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

			// update the last login date
			java.sql.Date currentDate = new java.sql.Date(new java.util.Date().getTime());
			loginUser.setLastLoginDate(currentDate);
			uService.updateUser(loginUser);
			
			// add session and cookie
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
	 * Profile setting page
	 */
	@RequestMapping("setting")
	public String setting(ModelMap model,
						  HttpSession session) {
		User currentUser = (User) session.getAttribute("USER_SESSION");
	
		// if no login, redirect to login page
		if (currentUser == null)
			return "redirect:/user/login";
		
		/*UserDTO userView = new UserDTO(currentUser);
		userView.setFromProvince(prService.getProvinceById(currentUser.getFromProvince()));
		userView.setFromCity(ctService.getCityById(currentUser.getFromCity()));
		userView.setPresentProvince(prService.getProvinceById(currentUser.getPresentProvince()));
		userView.setPresentCity(ctService.getCityById(currentUser.getPresentCity()));
		userView.setCollege(clgService.getCollegeById(currentUser.getCollege()));
		
		model.addAttribute("user", userView);*/
		
		model.addAttribute("user", currentUser);
		return "USER/setting";
	}
	
	/*
	 * 先判断更新了那些字段，然后存入数据库，再更新用户session和cookie
	 */
	@RequestMapping("setting/save")
	@ResponseBody
	public Map<String, Object> updateProfile(HttpSession session,
											 SessionStatus sessionStatus,
											 HttpServletRequest request,
											 HttpServletResponse response,
											 ModelMap model,
											 String intro,
											 String interest,
											 int sex,
											 String birth,
											 String website,
											 String name,
											 String newInputPassword) {
		User currentUser = (User) session.getAttribute("USER_SESSION");
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("intro: " + intro);
		System.out.println("interest: " + interest);
		System.out.println("sex: " + sex);
		System.out.println("birth: " + birth);
		System.out.println("website " + website);
		System.out.println("newInputPassword " + newInputPassword);
		
		if (currentUser == null) {
			result.put("isLogin", false);
			return result;
		}
		
		// save profile part
		try {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date date = format.parse(birth);
			java.sql.Date birthDate = new java.sql.Date(date.getTime());
			currentUser.setBirth(birthDate);
		} catch (ParseException e) {
			System.out.println(e.getMessage());
		}
		currentUser.setIntro(intro);
		currentUser.setInterest(interest);
		currentUser.setWebsite(website);
		currentUser.setSex(sex);
		// save username part
		currentUser.setName(name);
		// reset password
		if (!newInputPassword.equals(""))
			currentUser.setPassword(MD5Util.encryptCode(newInputPassword));
		
		// save the update
		try {
			uService.updateUser(currentUser);
			result.put("isDone", "ture");
		} catch (IncorrectUpdateSemanticsDataAccessException e) {
			System.out.println(e.getMessage());
			result.put("isDone", "false");
		}
		
		/*// clean the old session and cookie
		sessionStatus.setComplete();
		CookieUtil.removeCookie(request, response, "USER_COOKIE");
		// generate new session and cookie
		model.addAttribute("USER_SESSION", currentUser);
		response.addCookie(CookieUtil.generateUserCookie(currentUser));*/
		
		return result;
	}
	
	@RequestMapping("list")
	public String listUser(ModelMap model) {
		return "USER/list";
	}
	
}
