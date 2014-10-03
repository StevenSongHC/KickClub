package com.kc.model;

public class City {
	
	private int id;				// 主键id
	private String name;		// 城市名称
	private int provinceId;		// 所属省份id
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
	public int getProvinceId() {
		return provinceId;
	}
	public void setProvinceId(int provinceId) {
		this.provinceId = provinceId;
	}
	

}
