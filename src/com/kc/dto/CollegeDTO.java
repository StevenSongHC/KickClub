package com.kc.dto;

public class CollegeDTO {
	
	private int id;
	private String name;
	private String province;
	private String city;
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
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	
}
