package com.kc.service;

import java.util.List;

import com.kc.model.Province;

public interface ProvinceService {
	
	public int addProvince(Province province);
	
	public Province getProvinceById(int id);
	
	public List<Province> getAllProvince();

}
