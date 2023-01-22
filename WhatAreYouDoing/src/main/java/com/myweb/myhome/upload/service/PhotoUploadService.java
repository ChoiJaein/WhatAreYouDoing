package com.myweb.myhome.upload.service;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.myweb.myhome.upload.model.PhotoUploadDAO;
import com.myweb.myhome.upload.model.PhotoUploadDTO;

@Service
public class PhotoUploadService {

	private static final Logger logger = LoggerFactory.getLogger(PhotoUploadService.class);

	@Autowired
	private PhotoUploadDAO dao;
	
	@Transactional
	public int profileupload(MultipartFile file, PhotoUploadDTO data) throws Exception {
		
		logger.info("upload(file= {},data= {})", file, data);
		
		File folder = new File(data.getLocation());
		logger.info("folder check(folder= {})", folder);
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		UUID uuid = UUID.nameUUIDFromBytes(file.getBytes());
		System.out.println(uuid);
		
		data.setFileName(file.getOriginalFilename());
		data.setUuidName(uuid.toString());
		data.setFileSize((int)file.getSize());
		data.setFileType(file.getContentType());
		logger.info("data check(data= {})", data);
		
		boolean result = dao.insertProfileData(data);
		logger.info("insertProfileData Service result(result= {})", result);
		System.out.println(result);
		
		if(result) {
			try {
				file.transferTo(new File(data.getLocation() + File.separatorChar + data.getUuidName()));
				return 1;
			} catch (IOException e) {
				throw new Exception("서버에 파일 업로드를 실패하였습니다.");
			}
		} else {
			// 업로드 실패
			return 0;
		}
	}

}
