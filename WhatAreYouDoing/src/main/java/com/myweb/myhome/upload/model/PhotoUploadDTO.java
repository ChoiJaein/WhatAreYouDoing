package com.myweb.myhome.upload.model;

public class PhotoUploadDTO {
	
	private int fileId;
	private String userId;
	private String uuidName;
	private String fileName;
	private String location;
	private String url;
	private long fileSize;
	private String fileType;
	
	public PhotoUploadDTO() {}
	
	public PhotoUploadDTO(String userId, String location, String url) {
		this.userId = userId;
		this.location = location;
		this.url = url;
	}

	public int getFileId() {
		return fileId;
	}

	public void setFileId(int fileId) {
		this.fileId = fileId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUuidName() {
		return uuidName;
	}

	public void setUuidName(String uuidName) {
		this.uuidName = uuidName;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}

	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	@Override
	public String toString() {
		return "PhotoUploadDTO [fileId=" + fileId + ", userId=" + userId + ", uuidName=" + uuidName + ", fileName="
				+ fileName + ", location=" + location + ", url=" + url + ", fileSize=" + fileSize + ", fileType="
				+ fileType + "]";
	}
	
	
	

}
