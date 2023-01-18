package com.myweb.myhome.member.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myweb.myhome.member.model.MemberDAO;
import com.myweb.myhome.member.service.MemberService;
import com.myweb.myhome.member.vo.MemberVO;

@Service
public class MemberService {
	private static final Logger logger = LoggerFactory.getLogger(MemberService.class);

	@Autowired
	private MemberDAO dao;

	public void register(MemberVO vo) {
		logger.info("register(vo={})", vo);
		dao.register(vo);
	}
	
	public int idOverlap(MemberVO vo) {
		logger.info("idOverlap(MemberVO={})", vo);
		int result = dao.idOverlap(vo);
		return result;
	}
	
	// 전체 회원 정보 가져오기
	public MemberVO getAll(String userId) {
		logger.info("getAll(userId={})", userId);
		MemberVO data = dao.selectAll(userId);
		return data;
	}

	// 회원 정보 수정
	public boolean userModify(MemberVO vo) {
		logger.info("userModify(vo={})", vo);
		boolean result = dao.userModify(vo);
		return result;
	}

	public boolean signout(MemberVO vo) {
		logger.info("signout(vo={})", vo);
		boolean result = dao.signout(vo);
		return result;
	}


}
