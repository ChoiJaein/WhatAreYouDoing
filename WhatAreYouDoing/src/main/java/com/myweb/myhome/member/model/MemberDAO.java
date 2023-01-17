package com.myweb.myhome.member.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myweb.myhome.member.model.MemberDAO;
import com.myweb.myhome.member.vo.MemberVO;

@Repository
public class MemberDAO {
	private static final Logger logger = LoggerFactory.getLogger(MemberDAO.class);

	@Autowired
	private SqlSessionTemplate sqlSession;
	
//	private String mapper = "boardMapper.%s";

	// 회원가입
	public int register(MemberVO vo) {
		logger.info("register(vo={})", vo);
		return sqlSession.insert("memberMapper.register", vo);
		
	}
	
	// 아이디 중복확인
	public int idOverlap(MemberVO vo) {
		logger.info("idOverlap(MemberVO={})", vo);
		int result = sqlSession.selectOne("memberMapper.idOverlap", vo);
		return result;
	}


}
