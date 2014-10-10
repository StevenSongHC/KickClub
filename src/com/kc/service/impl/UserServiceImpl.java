package com.kc.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kc.dao.UserDAO;
import com.kc.model.User;
import com.kc.service.UserService;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserDAO uDao;
	
	public long addUser(User user) {
		return uDao.insert(user);
	}

	public User getUserByName(String name) {
		return uDao.getUserByName(name);
	}

	public User getUserByEmail(String email) {
		return uDao.getUserByEmail(email);
	}

}
