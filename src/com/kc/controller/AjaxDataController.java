package com.kc.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kc.dto.CityDTO;
import com.kc.dto.CollegeDTO;
import com.kc.model.City;
import com.kc.model.College;
import com.kc.model.User;
import com.kc.service.CityService;
import com.kc.service.CollegeService;
import com.kc.service.ProvinceService;
import com.kc.service.UserService;
import com.kc.util.MD5Util;

/*
 * For fetching data by Ajax
 * 用于Ajax获取数据
 */
@Controller
@RequestMapping("ajax")
public class AjaxDataController {

	@Autowired
	private UserService uService;
	@Autowired
	private ProvinceService prService;
	@Autowired
	private CityService ctService;
	@Autowired
	private CollegeService clgService;
	
	/*
	 * Return the entity data by id
	 * 根据id返回某一实体的数据
	 */
	@RequestMapping(value = "fetchEntityJSONDataById")
	@ResponseBody
	public Map<String, Object> getEntityJSONData(int id, String entityName) {
		System.out.println("fetchEntityJSONDataById");
		Map<String, Object> data = new HashMap<String, Object>();
		
		if (entityName.equals("province")) {
			data.put("data", JSONObject.fromObject(prService.getProvinceById(id)));
		}
		else if (entityName.equals("city")) {
			City city = ctService.getCityById(id);
			
			/*// Combine city view data
			CityDTO cityView = new CityDTO(city.getId(), city.getName());
			cityView.setProvince(prService.getProvinceById(city.getProvinceId()).getName());
			// Transform to Ajax data
			data.put("data", JSONObject.fromObject(cityView));*/
			
			StringBuilder sb = new StringBuilder();
			sb.append("{id:" + id);
			sb.append(",name:'" + city.getName());
			sb.append("',province:'" + prService.getProvinceById(city.getProvinceId()).getName() + "'}");
			
			data.put("data", JSONObject.fromObject(sb.toString()));
		}
		else if (entityName.equals("college")) {
			College college = clgService.getCollegeById(id);
			
			/*CollegeDTO collegeView = new CollegeDTO(college.getId(), college.getName(), college.getIntro());
			collegeView.setProvince(prService.getProvinceById(college.getProvinceId()).getName());
			collegeView.setCity(ctService.getCityById(college.getCityId()).getName());
			data.put("data", JSONObject.fromObject(collegeView));*/
			
			StringBuilder sb = new StringBuilder();
			sb.append("{id:" + id);
			sb.append(",name:'" + college.getName());
			sb.append("',province:'" + prService.getProvinceById(college.getProvinceId()).getName());
			sb.append("',city:'" + ctService.getCityById(college.getCityId()).getName());
			sb.append("',intro:'" + college.getIntro() + "'}");
			
			data.put("data", JSONObject.fromObject(sb.toString()));
		}
		
		return data;
	}
	
	/*
	 * Return province list
	 * 返回所支持的全部省份列表
	 */
	@RequestMapping(value = "getAllProvinceList")
	@ResponseBody
	public Map<String, Object> getAllProvinceList() {
		System.out.println("getAllProvinceList");
		Map<String, Object> provinceList = new HashMap<String, Object>();
		provinceList.put("list", prService.getAllProvince());
		return provinceList;
	}
	
	/*
	 * Return city list by the id of province
	 * 返回对应省份的城市列表
	 */
	@RequestMapping(value = "getCityListByProvinceId")
	@ResponseBody
	public Map<String, Object> getCityListByPrId(int provinceId) {
		System.out.println("getCityListByProvinceId");
		Map<String, Object> cityList = new HashMap<String, Object>();
		List<CityDTO> cityViewList = new ArrayList<CityDTO>();
		List<City> cityDataList = ctService.getCityListByProvinceId(provinceId);
		
		for (City city : cityDataList) {
			CityDTO cityView = new CityDTO(city.getId(), city.getName());
			cityView.setProvince(prService.getProvinceById(city.getProvinceId()));
			cityViewList.add(cityView);
		}
		
		cityList.put("list", cityViewList);
		return cityList;
	}
	
	/*
	 * Return college list by the province'id
	 * 返回对应省份的大学列表
	 */
	@RequestMapping(value = "getCollegeListByProvinceId")
	@ResponseBody
	public Map<String, Object> getCollegeListByProvinceId(int provinceId) {
		System.out.println("getCollegeListByProvinceId");
		Map<String, Object> collegeList = new HashMap<String, Object>();
		List<CollegeDTO> collegeViewList = new ArrayList<CollegeDTO>();
		List<College> collegeDataList = clgService.getCollegeListByProvinceId(provinceId);
		
		for (College college : collegeDataList) {
			CollegeDTO collegeView = new CollegeDTO(college.getId(), college.getName(), college.getIntro());
			collegeView.setProvince(prService.getProvinceById(college.getProvinceId()));
			collegeView.setCity(ctService.getCityById(college.getCityId()));
			collegeViewList.add(collegeView);
		}
		
		collegeList.put("list", collegeViewList);
		return collegeList;
	}
	
	/*
	 * Return college list by the city'id
	 * 返回对应城市的大学列表
	 */
	@RequestMapping(value = "getCollegeListByCityId")
	@ResponseBody
	public Map<String, Object> getCollegeListByCtId(int cityId) {
		System.out.println("getCollegeListByCityId");
		Map<String, Object> collegeList = new HashMap<String, Object>();
		List<CollegeDTO> collegeViewList = new ArrayList<CollegeDTO>();
		List<College> collegeDataList = clgService.getCollegeListByCityId(cityId);
		
		for (College college : collegeDataList) {
			CollegeDTO collegeView = new CollegeDTO(college.getId(), college.getName(), college.getIntro());
			collegeView.setProvince(prService.getProvinceById(college.getProvinceId()));
			collegeView.setCity(ctService.getCityById(college.getCityId()));
			collegeViewList.add(collegeView);
		}
		
		collegeList.put("list", collegeViewList);
		return collegeList;
	}
	
	/*
	 * Return city list
	 * 返回全部城市数据
	 */
	
	/*
	 * Check username
	 * 检测用户名（昵称）是否重复
	 */
	@RequestMapping(value = "checkUserName")
	@ResponseBody
	public Map<String, Object> checkUserName(String username) {
		Map<String, Object> result = new HashMap<String, Object>();
		if (uService.getUserByName(username) != null)
			result.put("isExisted", true);
		else
			result.put("isExisted", false);
		return result;
	}
	
	/*
	 * Validate password
	 * 验证密码是否正确
	 */
	@RequestMapping(value = "validatePassword")
	@ResponseBody
	public Map<String, Object> validatePassword(HttpSession session,  
												String inputPassword) {
		Map<String, Object> result = new HashMap<String, Object>();
		User currentUser = (User) session.getAttribute("USER_SESSION");
		if (currentUser == null)
			result.put("isLogin", false);
		else {
			result.put("isLogin", true);
			if (MD5Util.authenticateInputPassword(currentUser.getPassword(), inputPassword))
				result.put("isRight", true);
			else
				result.put("isRight", false);
		}
		return result;
	}
	
	/*
	 * Upload ajax form
	 * 使用ajax form 上传数据
	 */
	@RequestMapping(value = "ajaxFormSubmit")
	@ResponseBody
	public Map<String, Object> ajaxFormSubmit(HttpSession session,
											  HttpServletRequest request,
			  								  @RequestParam(value="uploadFile") MultipartFile uploadFile, 
											  String type,
											  String fileType) {
		Map<String, Object> result = new HashMap<String, Object>();
		User currentUser = (User) session.getAttribute("USER_SESSION");
		if (currentUser == null)
			result.put("isLogin", false);
		else {
			result.put("isLogin", true);
			if (type != null && !type.equals("")) {
				if (type.equals("userPhoto")) {
					String saveName = "images/portrait/" + currentUser.getId() + "_" + Calendar.getInstance().getTimeInMillis() + fileType;
					String savePath = request.getServletContext().getRealPath("") + "/" + saveName;
					
					if (!currentUser.getPhoto().equals("images/portrait/default.png")) {
						// delete the old portrait
						if (new File(request.getServletContext().getRealPath("")+ "/" +currentUser.getPhoto()).delete()) {
							// save the new portrait
							try {
								uploadFile.transferTo(new File(savePath));
								// update user portrait info
								currentUser.setPhoto(saveName);
								uService.updateUser(currentUser);
								result.put("isGood", true);
								result.put("newUserPhoto", currentUser.getPhoto());
							} catch (IOException e) {
								System.out.println("fail to save file");
								result.put("isGood", false);
								e.printStackTrace();
							}
						}
						else
							result.put("isGood", false);
					}
				}
			}
			
		}
		return result;
	}
	
}
