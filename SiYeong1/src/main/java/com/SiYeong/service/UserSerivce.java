package com.SiYeong.service;

import com.SiYeong.model.UserVO;

public interface UserSerivce {

	// 회원가입
	public void userJoin(UserVO user) throws Exception;
	
	// 아이디 중복 검사
	public int idCheck(String userId) throws Exception;
	
	 /* 로그인 */
    public UserVO userLogin(UserVO user) throws Exception;
}
