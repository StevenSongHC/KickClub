package com.kc.model;

import java.sql.Date;

public class User {
	private long id;					// 主键id
	private String email;				// 登陆用的email
	private String password;			// 密码
	private String name;				// 昵称，用户名
	private String photo;				// 头像
	private int sex;					// 性别
	private Date birth;					// 出生日期
	private String intro;				// 个人简介
	private String website;				// 个人网站
	private String interest;			// 兴趣爱好
	private int fromProvince;			// 来自的省份
	private int fromCity;				// 来自的城市
	private int presentProvince;		// 现居省份
	private int presentCity;			// 现居城市
	private String senior;				// 曾经就读的高中
	private int college;				// 现就读的大学
	private String collegeMajor;		// 大学所学专业
	private Date joinCollegeDate;		// 入学日期
	private Date joinDate;				// 注册该账号日期
	private Date lastLoginDate;			// 最后的登陆日期
	private int online;					// 是否在线
	private int accountStatus;			// 账号使用状态
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
	public Date getBirth() {
		return birth;
	}
	public void setBirth(Date birth) {
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
	public int getFromProvince() {
		return fromProvince;
	}
	public void setFromProvince(int fromProvince) {
		this.fromProvince = fromProvince;
	}
	public int getFromCity() {
		return fromCity;
	}
	public void setFromCity(int fromCity) {
		this.fromCity = fromCity;
	}
	public int getPresentProvince() {
		return presentProvince;
	}
	public void setPresentProvince(int presentProvince) {
		this.presentProvince = presentProvince;
	}
	public int getPresentCity() {
		return presentCity;
	}
	public void setPresentCity(int presentCity) {
		this.presentCity = presentCity;
	}
	public String getSenior() {
		return senior;
	}
	public void setSenior(String senior) {
		this.senior = senior;
	}
	public int getCollege() {
		return college;
	}
	public void setCollege(int college) {
		this.college = college;
	}
	public String getCollegeMajor() {
		return collegeMajor;
	}
	public void setCollegeMajor(String collegeMajor) {
		this.collegeMajor = collegeMajor;
	}
	public Date getJoinCollegeDate() {
		return joinCollegeDate;
	}
	public void setJoinCollegeDate(Date joinCollegeDate) {
		this.joinCollegeDate = joinCollegeDate;
	}
	public Date getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}
	public Date getLastLoginDate() {
		return lastLoginDate;
	}
	public void setLastLoginDate(Date lastLoginDate) {
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
