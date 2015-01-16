package com.kc.dto;

import com.kc.model.City;
import com.kc.model.College;
import com.kc.model.Province;
import com.kc.model.User;

public class UserDTO {
	
	private long id;
	private String email;
	private String password;
	private String name;
	private String photo;
	private int sex;
	private java.sql.Date birth;
	private String intro;
	private String website;
	private String interest;
	private Province fromProvince;
	private City fromCity;
	private Province presentProvince;
	private City presentCity;
	private String senior;
	private College college;
	private String collegeMajor;
	private java.sql.Date joinCollegeDate;
	private java.sql.Date joinDate;
	private java.sql.Date lastLoginDate;
	private int online;
	private int accountStatus;
	
	public UserDTO() {
		super();
	}
	public UserDTO(User user) {
		this.id = user.getId();
		this.email = user.getEmail();
		this.password = user.getPassword();
		this.name = user.getName();
		this.photo = user.getPhoto();
		this.sex = user.getSex();
		this.birth = user.getBirth();
		this.intro = user.getIntro();
		this.website = user.getWebsite();
		this.interest = user.getInterest();
		this.senior = user.getSenior();
		this.collegeMajor = user.getCollegeMajor();
		this.joinCollegeDate = user.getJoinCollegeDate();
		this.joinDate = user.getJoinDate();
		this.lastLoginDate = user.getLastLoginDate();
		this.online = user.getOnline();
		this.accountStatus = user.getAccountStatus();
	}
	
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public int getSex() {
		return sex;
	}
	public void setSex(int sex) {
		this.sex = sex;
	}
	public java.sql.Date getBirth() {
		return birth;
	}
	public void setBirth(java.sql.Date birth) {
		this.birth = birth;
	}
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	public String getWebsite() {
		return website;
	}
	public void setWebsite(String website) {
		this.website = website;
	}
	public String getInterest() {
		return interest;
	}
	public void setInterest(String interest) {
		this.interest = interest;
	}
	public Province getFromProvince() {
		return fromProvince;
	}
	public void setFromProvince(Province fromProvince) {
		this.fromProvince = fromProvince;
	}
	public City getFromCity() {
		return fromCity;
	}
	public void setFromCity(City fromCity) {
		this.fromCity = fromCity;
	}
	public Province getPresentProvince() {
		return presentProvince;
	}
	public void setPresentProvince(Province presentProvince) {
		this.presentProvince = presentProvince;
	}
	public City getPresentCity() {
		return presentCity;
	}
	public void setPresentCity(City presentCity) {
		this.presentCity = presentCity;
	}
	public String getSenior() {
		return senior;
	}
	public void setSenior(String senior) {
		this.senior = senior;
	}
	public College getCollege() {
		return college;
	}
	public void setCollege(College college) {
		this.college = college;
	}
	public String getCollegeMajor() {
		return collegeMajor;
	}
	public void setCollegeMajor(String collegeMajor) {
		this.collegeMajor = collegeMajor;
	}
	public java.sql.Date getJoinCollegeDate() {
		return joinCollegeDate;
	}
	public void setJoinCollegeDate(java.sql.Date joinCollegeDate) {
		this.joinCollegeDate = joinCollegeDate;
	}
	public java.sql.Date getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(java.sql.Date joinDate) {
		this.joinDate = joinDate;
	}
	public java.sql.Date getLastLoginDate() {
		return lastLoginDate;
	}
	public void setLastLoginDate(java.sql.Date lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}
	public int getOnline() {
		return online;
	}
	public void setOnline(int online) {
		this.online = online;
	}
	public int getAccountStatus() {
		return accountStatus;
	}
	public void setAccountStatus(int accountStatus) {
		this.accountStatus = accountStatus;
	}
	
}
