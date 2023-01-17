package com.myweb.myhome.login.model;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myweb.myhome.login.model.LoginDAO;

@Repository
public class LoginDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(LoginDAO.class);

	@Autowired
	private SqlSession session;
	
	// 로그인
	public LoginDTO selectLogin(LoginDTO data) {
		logger.info("selectLogin({},{})",data);
		LoginDTO result = session.selectOne("loginMapper.selectLogin", data);
		return result;
	}


}
