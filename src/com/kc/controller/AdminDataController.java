package com.kc.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kc.dto.CityDTO;
import com.kc.dto.CollegeDTO;
import com.kc.model.City;
import com.kc.model.College;
import com.kc.model.Province;
import com.kc.service.CityService;
import com.kc.service.CollegeService;
import com.kc.service.ProvinceService;
import com.kc.service.UserService;

/*
 * Controller for some sensitive data, requires admin authority verified
 * 控制对关键数据的操作，需要权限
 */
@Controller
@RequestMapping("data")
public class AdminDataController {

	@Autowired
	private UserService uService;
	@Autowired
	private ProvinceService prService;
	@Autowired
	private CityService ctService;
	@Autowired
	private CollegeService clgService;
	
	/*
	 * Link to data navigation page
	 * 转到数据导航页
	 */
	@RequestMapping
	public String dataNaviPage(ModelMap model) {
		return "DATA/data-navi";
	}
	
	/*
	 * Link to user data page
	 */
	@RequestMapping("user")
	public String userDataPage(ModelMap model) {
		
		return "DATA/data-user-list";
	}
	
	/*
	 * Link to province data page
	 */
	@RequestMapping("province")
	public String provinceDataPage(ModelMap model) {
		model.addAttribute("provinceList", prService.getAllProvince());
		return "DATA/data-province-list";
	}
	
	/*
	 * Link to city data page
	 */
	@RequestMapping("city")
	public String cityDataPage(ModelMap model) {
		List<CityDTO> cityViewList = new ArrayList<CityDTO>();
		List<City> cityDataList = ctService.getAllCity();
		for (City city :cityDataList) {
			CityDTO cityView = new CityDTO(city.getId(), city.getName());
			cityView.setProvince(prService.getProvinceById(city.getProvinceId()).getName());
			cityViewList.add(cityView);
		}
		model.addAttribute("cityList", cityViewList);
		// Add hidden select element
		model.addAttribute("provinceList", prService.getAllProvince());
		return "DATA/data-city-list";
	}
	
	/*
	 * Link to college data page
	 */
	@RequestMapping("college")
	public String collegeDataPage(ModelMap model) {
		List<CollegeDTO> collegeViewList = new ArrayList<CollegeDTO>();
		List<College> collegeDataList = clgService.getAllCollege();
		for (College college : collegeDataList) {
			// Raw data
			CollegeDTO collegeView = new CollegeDTO(college.getId(), college.getName(), college.getIntro());
			// Data for view
			collegeView.setProvince(prService.getProvinceById(college.getProvinceId()).getName());
			collegeView.setCity(ctService.getCityById(college.getCityId()).getName());
			
			collegeViewList.add(collegeView);
		}
		model.addAttribute("collegeList", collegeViewList);
		// Add hidden select element
		model.addAttribute("provinceList", prService.getAllProvince());
		return "DATA/data-college-list";
	}
	
	/*
	 * Insert a province data
	 */
	@RequestMapping(value = "insert/province")
	@ResponseBody
	public Map<String, Object> insertProvince(String jsonDataAttr) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		JSONObject attr = JSONObject.fromObject(jsonDataAttr);
		
		Province province = new Province();
		province.setName(attr.getString("provinceName"));
		prService.addProvince(province);
		
		result.put("maxId", province.getId());
		return result;
	}
	
	/*
	 * Insert a city data
	 */
	@RequestMapping(value = "insert/city")
	@ResponseBody
	public Map<String, Object> insertCity(String jsonDataAttr) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		JSONObject attr = JSONObject.fromObject(jsonDataAttr);
		
		City city = new City();
		city.setName(attr.getString("cityName"));
		city.setProvinceId(attr.getInt("provinceId"));
		ctService.addCity(city);
		
		result.put("maxId", city.getId());
		return result;
	}
	
	/*
	 * Insert a city data
	 */
	@RequestMapping(value = "insert/college")
	@ResponseBody
	public Map<String, Object> insertCollege(String jsonDataAttr) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		JSONObject attr = JSONObject.fromObject(jsonDataAttr);
		
		College college = new College();
		college.setName(attr.getString("collegeName"));
		college.setProvinceId(attr.getInt("provinceId"));
		college.setCityId(attr.getInt("cityId"));
		college.setIntro(attr.getString("collegeIntro"));
		clgService.addCollege(college);
		
		result.put("maxId", college.getId());
		return result;
	}
	
}
