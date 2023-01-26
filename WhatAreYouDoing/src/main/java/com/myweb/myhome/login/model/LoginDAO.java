package com.myweb.myhome.login.model;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myweb.myhome.login.model.LoginDAO;
import com.myweb.myhome.member.vo.MemberVO;

@Repository
public class LoginDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(LoginDAO.class);

	@Autowired
	private SqlSession session;
	
	// 로그인
	public LoginDTO selectLogin(LoginDTO data) {
		logger.info("selectLogin(data={})",data);
		LoginDTO result = session.selectOne("loginMapper.selectLogin", data);
		return result;
	}

	public LoginDTO findId(String email) {
		logger.info("findId(email={})", email);
		LoginDTO result = session.selectOne("loginMapper.findId", email);
		return result;
	}

	public int updatePw(MemberVO vo) {
		logger.info("updatePw(vo={})", vo);
		int result = session.update("loginMapper.updatePw", vo);
		return result;
	}


}
