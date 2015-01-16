package com.kc.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.kc.model.User;

@Repository
@Transactional
public interface UserDAO {
	
	public long insert(User user);
	
	public User getUserById(long id);
	
	public User getUserByName(String name);
	
	public User getUserByEmail(String email);
	
	public List<User> getUserList();
	
	public boolean update(User user);
	
	// return last uid
	/*public int addUser(User user);
	
	public void deleteUser(int uid);
	
	public User getUserByUid(int uid);
	
	public void updateUser(User user);*/
	
}
