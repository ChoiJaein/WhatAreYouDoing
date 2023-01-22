package com.myweb.myhome.post.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;



@Repository
public class PostDAO {
	private static final Logger logger = LoggerFactory.getLogger(PostDAO.class);

	@Autowired
	private SqlSession session;
	private String mapper = "postMapper.%s";
		
	// 메인페이지. 전체 게시글 목록
	public List<PostDTO> selectAll() {
		logger.info("all post list DAO");
		String mapperId = String.format(mapper, "selectAll");
		List<PostDTO> res = session.selectList(mapperId);
		return res;
	}

	// 게시글 번호 자동 생성을 위한 시퀀스
	public int getNextSeq() {
		logger.info("getNextSeq(seq={})");
		String mapperId = String.format(mapper, "getNextSeq");
		int seq = session.selectOne(mapperId);
		logger.info("getNextSeq(seq={})", seq);
		return seq;
	}

	// 게시글 추가
	public boolean insertData(PostDTO data) {
		logger.info("insertData(data={})", data);
		String mapperId = String.format(mapper, "insertData");
		int res = session.insert(mapperId, data);
		logger.info("finish insertData(data={})", data);
		return res == 1 ? true : false;
	}

	// 상세페이지를 위한 데이터 불러오기
	public PostDTO selectData(int postId) {
		logger.info("selectData(postId={})", postId);
		String mapperId = String.format(mapper, "selectData");
		PostDTO res = session.selectOne(mapperId, postId);
		logger.info("selectData Result(res={})", res);
		return res;
	}

	// 게시글 수정
	public boolean updateData(PostDTO data) {
		logger.info("updateData(data={})", data);
		String mapperId = String.format(mapper, "updateData");
		int res = session.update(mapperId, data);
		return res == 1 ? true : false;
	}

	// 게시글 삭제
	public boolean deleteData(PostDTO data) {
		logger.info("deleteData(data={})", data);
		String mapperId = String.format(mapper, "deleteData");
		int res = session.delete(mapperId, data);
		return res >= 0 ? true : false;
	}
	
		
	

}
