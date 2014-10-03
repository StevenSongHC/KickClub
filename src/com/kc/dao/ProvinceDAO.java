package com.kc.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.kc.model.Province;

@Repository
@Transactional
public interface ProvinceDAO {
	
	public int insert(Province province);
	
	public Province getProvinceById(int id);

	public List<Province> getAllProvince();
	
}
