package com.myweb.myhome.upload.model;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PhotoUploadDAO {
	private static final Logger logger = LoggerFactory.getLogger(PhotoUploadDAO.class);
	
	@Autowired
	private SqlSession session;
	
	public int getCount(String userId) {
		int res = session.selectOne("photoUploadMapper.getCount", userId);
		return res;
	}

	public boolean insertProfileData(PhotoUploadDTO data) {
		logger.info("insertProfileData(data= {})", data);
		int res = session.insert("photoUploadMapper.insertProfileData", data);
		logger.info("insertProfileData result(res= {})", res);
		System.out.println(res);
		return res == 1 ? true : false;
	}
	
	
	public boolean deleteProfilePhoto(String userId) {
		logger.info("deleteProfilePhoto(userId={})", userId);
		int res = session.delete("photoUploadMapper.deleteUserPhoto", userId);
		return res == 1 ? true : false;
	}
	

//	public void defaultProfile(String userId) {
//		logger.info("deleteProfilePhoto(userId={})", userId);
//		session.insert("photoUploadMapper.defaultProfile", userId);
//	}

}
