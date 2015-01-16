package com.kc.service;

import com.kc.model.User;

public interface UserService {
	
	public long addUser(User user);
	
	public User getUserById(long id);
	
	public User getUserByName(String name);
	
	public User getUserByEmail(String email);
	
	public boolean updateUser(User user);

}
