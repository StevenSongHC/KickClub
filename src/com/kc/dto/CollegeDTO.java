package com.kc.dto;

import com.kc.model.City;
import com.kc.model.Province;

public class CollegeDTO {
	
	private int id;
	private String name;
	private Province province;
	private City city;
	private String intro;
	
	public CollegeDTO() {
		super();
	}
	public CollegeDTO(int id, String name, String intro) {
		this.id = id;
		this.name = name;
		this.intro = intro;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Province getProvince() {
		return province;
	}
	public void setProvince(Province province) {
		this.province = province;
	}
	public City getCity() {
		return city;
	}
	public void setCity(City city) {
		this.city = city;
	}
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	
}
