package com.kc.service;

import java.util.List;

import com.kc.model.City;

public interface CityService {
	
	public int addCity(City city);
	
	public City getCityById(int id);
	
	public List<City> getAllCity();
	
	public List<City> getCityListByProvinceId(int provinceId);

}
