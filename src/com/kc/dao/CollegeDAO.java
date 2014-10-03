package com.kc.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.kc.model.College;

@Repository
@Transactional
public interface CollegeDAO {
	
	public int insert(College college);

	public College getCollegeById(int id);
	
	public List<College> getAllCollege();
	
	public List<College> getCollegeListByCityId(int cityId);
	
}
