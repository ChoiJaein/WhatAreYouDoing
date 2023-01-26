<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원가입</title>
	<%@ include file="../module/head.jsp" %>
	
	<style type="text/css">
	.register-box {
		margin:auto;
		background-color: rgba(250, 237, 197, 0.5);
		border-radius: 10px;
		padding:20px 30px;
		width:460px;
		}
		
	.input-file-button{
	  padding: 4px 15px;
	  background-color:#58636A;
	  border-radius: 4px;
	  color: white;
	  cursor: pointer;
	}
	
	.upload-box {
		width: 180px;
		height: 180px;
		background-color: lightgray;
	}
		
	</style>
	
	
</head>

<script type="text/javascript">
	/* 아이디 중복 확인 */
 	function idOverlap() {
		console.log("idOverlap 호출")
		console.log("아이디 입력 값 " + $("#id_userId").val())
		$.ajax({
			url : "idOverlap",
			type : "post",
			data : {"userId" : $("#id_userId").val()},
			dataType : "json",
			success : function(data) {
				if(data.code == "fail") {
					alert("이미 사용중인 아이디입니다. 다른 아이디를 입력하세요.");
					$("#button_register").attr("disabled",true); 
				} else if(data.code == "success") {
					alert("사용 가능한 아이디입니다.");
					$("#button_register").removeAttr("disabled"); 
				}
			}
		})
	} 

	
	 
	/* 비밀번호 확인 */
	function passConfirm() {
		var userPw = document.getElementById('id_userPw');
		var userPwConfirm = document.getElementById('id_userPwConfirm');
		var confirmMsg = document.getElementById('confirmMsg');
		var correctColor = "#929292";	//맞았을 때 출력되는 색깔.
		var wrongColor ="#DA936D";	//틀렸을 때 출력되는 색깔
		
		if(userPw.value == userPwConfirm.value) {
			confirmMsg.style.color = correctColor;
			confirmMsg.innerHTML = "비밀번호가 일치합니다.";
			$("#button_register").removeAttr("disabled"); 
		} else {
			confirmMsg.style.color = wrongColor;
			confirmMsg.innerHTML = "비밀번호가 일치하지 않습니다.";
			$("#button_register").attr("disabled",true); 
		}
	}
</script>

<body>
	<header>
	<%@ include file="../module/navigation.jsp" %>
	</header>
	<c:url var="mainUrl" value="." />
	<section class="container" style="width: 480px;">
		<c:url var="registerUrl" value="/register" />
		<form id="ajaxform" action="${registerUrl}" name="register" method="post" enctype="multipart/form-data">
			<br><br>
			<input type="hidden" name="url" value="${param.url}">
			
			<div class="register-box">
			
				<div class="text-center">
					<img id="previewImg" class="image-360 mt-5 mb-4" alt="profile" src="./static/img/profile/default_profile.png" 
										width="180" height="180" >
				</div>
				<%-- <div class="text-center">
					<img id="previewImg" class="image-360 mt-5 mb-4" alt="profile" src="<%=request.getContextPath() %>${photo.url}" 
										width="180" height="180" >
				</div> --%>
			
				<div class="text-center">
					<label class="input-file-button mb-4" for="imgSelect">프로필사진 변경</label>
					<input id="imgSelect" name="photoUpload" type="file" onchange="preview()" style ="display:none;">
				</div> 
				
	 			<div class="form-floating mb-2">
					<input class="form-control" type="text" id="id_userId" name="userId" value="" placeholder="아이디를 입력하세요" required>
					<label for="id_userId">아이디</label>
					<input type="button" onclick="idOverlap()" value="중복확인" />
				</div>
				<br>
				<div class="form-floating mb-2">
					<input class="form-control" type="password" id="id_userPw" name="userPw" value="" placeholder="비밀번호를 입력하세요" required>
					<label for="id_userPw">비밀번호</label>
				</div>
				<div class="form-floating mb-2">
					<input class="form-control" type="password" id="id_userPwConfirm" name="userPwConfirm" placeholder="비밀번호를 입력하세요" onkeyup="passConfirm()" required>
					<label for="id_userPwConfirm">비밀번호 확인</label>
					<span id ="confirmMsg"></span>
				</div>
				<br>
				
				<div class="form-floating mb-2">
					<input class="form-control" type="text" id="id_userName" name="userName" value="" placeholder="닉네임을 입력하세요" required>
					<label for="id_userName">닉네임</label>
				</div>
				<br>
				<div class="form-floating mb-2">
					<input class="form-control" type="text" id="id_userEmail" name="userEmail" value="" placeholder="이메일을 입력하세요" required>
					<label for="id_userEmail">이메일</label>
				</div>
			</div>
			
			<br><br>
			
			<div class="mb-2 text-end">
				<button class="btn btn-outline-secondary" type="submit" id="button_register" disabled>가입하기</button>
			</div>
			
			<br>
		</form>
	</section>
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
	</script>
	



</body>
</html>