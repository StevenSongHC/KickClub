package com.kc.controller;

import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kc.dto.CityDTO;
import com.kc.model.City;
import com.kc.service.CityService;
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
	@RequestMapping(value = "getCityListByProvinceName")
	@ResponseBody
	public Map<String, Object> getCityListByPrName(String provinceName) {
		System.out.println("getCityListByProvinceName");
		Map<String, Object> provinceList = new HashMap<String, Object>();
		System.out.println("prName:" + provinceName);
		return provinceList;
	}
	
	/*
	 * Return city list
	 * 返回全部城市数据
	 */
	
}
