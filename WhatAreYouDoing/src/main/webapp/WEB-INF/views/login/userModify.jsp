<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page import="java.util.*" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 회원정보 수정 </title>
 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" 
 integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<%@ include file="../module/head.jsp" %>
 
<style type="text/css">
	.modify-box {
	margin:auto;
	background-color: rgba(250, 237, 197, 0.5);
	border-radius: 10px;
	padding:20px 30px;
	width:460px;
	}
	
	h1 {
	text-align: center;
	color: gray;
	text-shadow: <50> <50> <50> <red>;
	}
	
	.input-file-button{
	  padding: 4px 15px;
	  background-color:#7F8080;
	  border-radius: 4px;
	  color: white;
	  cursor: pointer;
	}
	
	.btn-box {
	margin: auto;
	width: 460px;
	}
</style>
</head>


<body>
	<header>
	<%@ include file="../module/navigation.jsp" %>
	</header>
 
 	<section class="container">
  
  
	<c:url var="myinfoModify" value="/modify"/>
	<form id="ajaxform" class="large-form" action="${myinfoModify}" method="post" enctype="multipart/form-data">


	<br><br>
	<h1>회원 정보</h1>
	<br>
		<div class="modify-box">	
			<div class="text-center">
				<img id="previewImg" class="image-360 mt-5 mb-4" alt="profile" src="<%=request.getContextPath() %>${photo.url}" 
									style="width:180px; height:180px; margin-top: 28px; border-radius: 30%;">
			</div>
			<div class="text-center">
				<label class="input-file-button mb-4" for="imgSelect">프로필사진 변경</label>
				<input id="imgSelect" name="photoUpload" type="file" onchange="preview()" style ="display:none;">
			</div> 
		
			<div class="input-group">
				<label class="input-label w-100">아이디</label>
				<input class="form-control  form-control-lg  w-100 mb-3" type="text" name="userId" value="${data.userId}" style="background-color: white" readonly>
			</div>
			<div class="input-group">
				<label class="input-label w-100">비밀번호</label>
				<input class="form-control  form-control-lg w-auto mb-3" type="password" name="userPw" value="" required>
			</div>
			<div class="input-group">
				<label class="input-label w-100">닉네임</label>
				<input class="form-control   form-control-lg w-auto mb-3" type="text" name="userName" value="${data.userName}" required>
			</div>
			<div class="input-group">
				<label class="input-label w-100">이메일</label>
				<input class="form-control   form-control-lg w-auto mb-3" type="text" name="userEmail" value="${data.userEmail}" required>
			</div>
		</div>
<br>
	 <div class="btn-box text-end">
	    <button class="btn btn-outline-danger" onclick="return unregister();">탈 퇴</button>   
	    <button class="btn btn-outline-secondary" type="submit">수 정</button>
	  </div>			
 </form>
 </section>

<!--하단 -->
<footer>

</footer>


<script type="text/javascript">



function preview() { 
	previewImg.src=URL.createObjectURL(event.target.files[0]); 
}

<!--이미지 업로드 미리보기-->
function showImagePreview(e){
	 var file = e.target.files[0];
	 var imgUrl = URL.createObjectURL(file);
	 previewImg.src = imgUrl;	 
}


<!--이미지 업로드 Ajax-->
function ajaxImageUpload(e){
	 var file  =  e.target.files[0];
	 var fData = new FormData();
	 fData.append("uploadImage", file, file.name);
	 
	 $.ajax({
		 type:"post",
		 enctype:"multipart/form-data",
		 url:"/ajax/imageUpload",
		 data:fData,
		 processData:false,
	     contentType:false,
	     success:function(data, status){
	    	 previewImg.src = data.src;
	     }
	  
	 });
} 
 
 <!--회원탈퇴 check-->
 <!--경로 수정할것.-->
 function unregister(){
	 if(confirm("회원탈퇴를 진행하시겠습니까?")==true){
		 location.href="/signout";
	 }else{
		 return false;
	 }
 }
 
  
<!--완료 check-->
<!--경로 수정할것.-->
 function myInfoModiCheck(form){
	if(confirm("수정하시겠습니까?") == true){
		form.submit();
	    alert("수정이 완료되었습니다.");
	}else{
		return false;
	}
 }
 </script>
 
 
</script>
</body>
</html>