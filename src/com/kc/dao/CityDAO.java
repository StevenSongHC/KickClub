package com.kc.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.kc.model.City;

@Repository
@Transactional
public interface CityDAO {

	public int insert(City city);
	
	public City getCityById(int id);
	
	public List<City> getAllCity();
	
	public List<City> getCityListByProvinceId(int provinceId);
	
}
