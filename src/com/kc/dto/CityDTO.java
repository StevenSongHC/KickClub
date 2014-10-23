package com.kc.dto;

import com.kc.model.Province;

public class CityDTO {
	
	private int id;
	private String name;
	private Province province;
	
	public CityDTO() {
		super();
	}
	public CityDTO(int id, String name) {
		this.id = id;
		this.name = name;
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
	
}
