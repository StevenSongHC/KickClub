package com.kc.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kc.dto.CityDTO;
import com.kc.dto.CollegeDTO;
import com.kc.model.City;
import com.kc.model.College;
import com.kc.service.CityService;
import com.kc.service.CollegeService;
import com.kc.service.ProvinceService;
import com.kc.service.UserService;

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
			// Combine city view data
			CityDTO cityView = new CityDTO(city.getId(), city.getName());
			cityView.setProvince(prService.getProvinceById(city.getProvinceId()).getName());
			// Transform to Ajax data
			data.put("data", JSONObject.fromObject(cityView));
		}
		else if (entityName.equals("college")) {
			College college = clgService.getCollegeById(id);
			
			/*CollegeDTO collegeView = new CollegeDTO(college.getId(), college.getName(), college.getIntro());
			collegeView.setProvince(prService.getProvinceById(college.getProvinceId()).getName());
			collegeView.setCity(ctService.getCityById(college.getCityId()).getName());
			data.put("data", JSONObject.fromObject(collegeView));*/
			
			StringBuilder sb = new StringBuilder();
			sb.append("{id:" +id);
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
	public Map<String, Object> getCityListByPrName(int provinceId) {
		System.out.println("getCityListByProvinceName");
		Map<String, Object> cityList = new HashMap<String, Object>();
		List<CityDTO> cityViewList = new ArrayList<CityDTO>();
		List<City> cityDataList = ctService.getCityListByProvinceId(provinceId);
		
		for (City city : cityDataList) {
			CityDTO cityView = new CityDTO(city.getId(), city.getName());
			cityView.setProvince(prService.getProvinceById(city.getProvinceId()).getName());
			cityViewList.add(cityView);
		}
		
		cityList.put("list", cityViewList);
		return cityList;
	}
	
	/*
	 * Return college list by the city'id
	 * 返回对应省份的城市列表
	 */
	@RequestMapping(value = "getCollegeListByCityId")
	@ResponseBody
	public Map<String, Object> getCollegeListByPrName(int cityId) {
		System.out.println("getCollegeListByCityId");
		Map<String, Object> collegeList = new HashMap<String, Object>();
		List<CollegeDTO> collegeViewList = new ArrayList<CollegeDTO>();
		List<College> collegeDataList = clgService.getCollegeListByCityId(cityId);
		
		for (College college : collegeDataList) {
			CollegeDTO collegeView = new CollegeDTO(college.getId(), college.getName(), college.getIntro());
			collegeView.setProvince(prService.getProvinceById(college.getProvinceId()).getName());
			collegeView.setCity(ctService.getCityById(college.getCityId()).getName());
			collegeViewList.add(collegeView);
		}
		
		collegeList.put("list", collegeViewList);
		return collegeList;
	}
	
	/*
	 * Return city list
	 * 返回全部城市数据
	 */
	
}
