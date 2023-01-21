package com.myweb.myhome.post.model;

import java.sql.Date;

public class PostDTO {
	
	private int postId;
	private String userId;
	private String postTitle;
	private String postContent;
	private Date postDate;
	
	public int getPostId() {
		return postId;
	}
	
	public void setPostId(int postId) {
		this.postId = postId;
	}
	
	public String getPostTitle() {
		return postTitle;
	}
	
	public void setPostTitle(String postTitle) {
		this.postTitle = postTitle;
	}
	
	public String getPostContent() {
		return postContent;
	}
	
	public void setPostContent(String postContent) {
		this.postContent = postContent;
	}
	
	public Date getPostDate() {
		return postDate;
	}
	
	public void setPostDate(Date postDate) {
		this.postDate = postDate;
	}
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	@Override
	public String toString() {
		return "PostDTO [postId=" + postId + ", userId=" + userId + ", postTitle=" + postTitle + ", postContent="
				+ postContent + ", postDate=" + postDate + "]";
	}


}
