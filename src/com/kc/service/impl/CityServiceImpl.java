package com.kc.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kc.dao.CityDAO;
import com.kc.model.City;
import com.kc.service.CityService;

@Service
public class CityServiceImpl implements CityService {

	@Autowired
	private CityDAO ctDao;
	
	public int addCity(City city) {
		return ctDao.insert(city);
	}
	

	public City getCityById(int id) {
		return ctDao.getCityById(id);
	}

	public List<City> getAllCity() {
		return ctDao.getAllCity();
	}

	public List<City> getCityListByProvinceId(int provinceId) {
		return ctDao.getCityListByProvinceId(provinceId);
	}

}
