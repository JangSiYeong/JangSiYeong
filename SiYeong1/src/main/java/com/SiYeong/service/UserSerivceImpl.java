package com.SiYeong.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.SiYeong.mapper.UserMapper;
import com.SiYeong.model.UserVO;

@Service
public class UserSerivceImpl implements UserSerivce{

	@Autowired
	UserMapper usermapper;
	
	@Override
	public void userJoin(UserVO user) throws Exception
	{
		usermapper.userJoin(user);
	}
	
	@Override
	public int idCheck(String userId) throws Exception {
		
		return usermapper.idCheck(userId);
	}
	
	@Override
	public UserVO userLogin(UserVO user) throws Exception {
		
		return usermapper.userLogin(user);
	}
}
