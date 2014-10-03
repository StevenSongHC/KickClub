package com.kc.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kc.dao.ProvinceDAO;
import com.kc.model.Province;
import com.kc.service.ProvinceService;

@Service
public class ProvinceServiceImpl implements ProvinceService {

	@Autowired
	private ProvinceDAO prDao;

	public int addProvince(Province province) {
		return prDao.insert(province);
	}
	
	public Province getProvinceById(int id) {
		return prDao.getProvinceById(id);
	}
	
	public List<Province> getAllProvince() {
		return prDao.getAllProvince();
	}
	
}
