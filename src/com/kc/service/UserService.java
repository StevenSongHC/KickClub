package com.kc.service;

import com.kc.model.User;

public interface UserService {
	
	public long addUser(User user);
	
	public User getUserByName(String name);

}
