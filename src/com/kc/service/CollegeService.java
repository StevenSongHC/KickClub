package com.kc.service;

import java.util.List;

import com.kc.model.College;

public interface CollegeService {
	
	public int addCollege(College college);
	
	public College getCollegeById(int id);
	
	public List<College> getAllCollege();
	
	public List<College> getCollegeListByCityId(int cityId);
	
}
