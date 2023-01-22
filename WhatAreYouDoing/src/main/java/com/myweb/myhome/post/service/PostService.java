package com.myweb.myhome.post.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myweb.myhome.post.model.PostDAO;
import com.myweb.myhome.post.model.PostDTO;

@Service
public class PostService {
	private static final Logger logger = LoggerFactory.getLogger(PostService.class);


	@Autowired
	private PostDAO dao;
	
	// 메인페이지. 전체 게시글 목록
	public List<PostDTO> getAll(String userId) {
		logger.info("getAll(userId={})", userId);
		List<PostDTO> datas = dao.selectAll(userId);
		return datas;
	}

	// 게시글 추가
	public int add(PostDTO data) {
		logger.info("add(PostService={})", data);
		int seq = dao.getNextSeq();
		data.setPostId(seq);
		logger.info("check PostId(PostId={})", data.getPostId());
		
		boolean result = dao.insertData(data);
		logger.info("finish insertData(data={})", data);
		
		if(result) {
			return data.getPostId();
		}
		return -1;
	}

	public PostDTO getData(int postId) {
		logger.info("getData(postId={})", postId);
		PostDTO data = dao.selectData(postId);
		logger.info("getData Result(data={})", data);
		return data;
	}

	public boolean modify(PostDTO data) {
		logger.info("modify(data={})", data);
		boolean result = dao.updateData(data);
		return result;
	}

	public boolean remove(PostDTO data) {
		logger.info("remove(data={})", data);
		
		boolean result = dao.deleteData(data);
		
		return result;
	}
	
	
}
