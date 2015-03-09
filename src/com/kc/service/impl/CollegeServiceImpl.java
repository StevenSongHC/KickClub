package com.kc.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kc.dao.CollegeDAO;
import com.kc.model.College;
import com.kc.service.CollegeService;

@Service
public class CollegeServiceImpl implements CollegeService {
	
	@Autowired
	private CollegeDAO clgDao;

	public int addCollege(College college) {
		return clgDao.insert(college);
	}
	
	public College getCollegeById(int id) {
		return clgDao.getCollegeById(id);
	}

	public List<College> getAllCollege() {
		return clgDao.getAllCollege();
	}
	
	public List<College> getCollegeListByProvinceId(int cityId) {
		return clgDao.getCollegeListByProvinceId(cityId);
	}

	public List<College> getCollegeListByCityId(int cityId) {
		return clgDao.getCollegeListByCityId(cityId);
	}

}
