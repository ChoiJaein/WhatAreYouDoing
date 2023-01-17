package com.myweb.myhome.login.service;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myweb.myhome.login.model.LoginDAO;
import com.myweb.myhome.login.model.LoginDTO;
import com.myweb.myhome.login.service.LoginService;
import com.myweb.myhome.login.vo.LoginVO;

@Service
public class LoginService<loginDTO> {
	
	private static final Logger logger = LoggerFactory.getLogger(LoginService.class);

	@Autowired
	 private LoginDAO dao;

	// 로그인
	public boolean getLogin(HttpSession session, LoginVO loginVo) {
		logger.info("getLogin({},{}" ,session, loginVo);
		LoginDTO data = new LoginDTO();
		data.setUserId(loginVo.getUserId());
		data.setUserPw(loginVo.getUserPw());
		
		data = dao.selectLogin(data);
		
		if(data != null) {
			session.setAttribute("loginData", data);
			return true;
		} else {
			return false;
		}
	}
}
