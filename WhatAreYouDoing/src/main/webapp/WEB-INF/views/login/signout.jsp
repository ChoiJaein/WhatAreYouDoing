<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원탈퇴</title>
	<%@ include file="../module/head.jsp" %>
	
	<style type="text/css">
	.signout-box {
	margin:auto;
	background-color: rgba(250, 237, 197, 0.5);
	border-radius: 10px;
	padding:20px 30px;
	width:460px;
	}
</style>
	
	
</head>
<script type="text/javascript">

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
			$("#signout-btn").removeAttr("disabled"); 
		} else {
			confirmMsg.style.color = wrongColor;
			confirmMsg.innerHTML = "비밀번호가 일치하지 않습니다.";
			$("#signout-btn").attr("disabled",true); 
		}
	}
 

</script>

<body>
	
	<header>
	<%@ include file="../module/navigation.jsp" %>
	</header>
	
	<section class="container">
	
	
	<c:url var="signOut" value="/signout"/>
	<form class="large-form" action="${signOut}" method="post" enctype="multipart/form-data">
	
		<%-- <div class="div-bc div-left">
		
			<div class="div-middle">
			
			
			
			 	<div class="div-profile" style="position:absolute; left:-20px; top:-100px;">
					<img src="<%=request.getContextPath()%>${photo.url}" alt="프로필사진" />
				</div> 
				
				
				<div class="div-profile" style="position:absolute; top:130px;">
					<input type="text" id="id_name" name="name" value="${data.name}" readonly>
				</div>
			</div>
			
		</div> --%>
		
		<br><br>
	
	
		<div class="signout-box">	
			<div class="input-group">
				<label class="input-label w-100">아이디</label>
				<input class="form-control  form-control-lg  w-100 mb-3" type="text" name="userId" value="${data.userId}" readonly>
			</div>
			<div class="input-group">
				<label class="input-label w-100">비밀번호</label>
				<input class="form-control  form-control-lg w-auto mb-3" 
				type="password" id="id_userPw" name="userPw" value="${data.userPw}" readonly>
			</div>
			<div class="input-group">
				<label class="input-label w-100">비밀번호 확인</label>
				<input class="form-control  form-control-lg w-100 mb-1" 
				type="password" id="id_userPwConfirm" name="userPwConfirm" onkeyup="passConfirm()" required>
				<span id ="confirmMsg"></span>
			</div>
		</div>
	
		
	<div>
		<button class="btn btn-primary button-right" onclick="location.href='/myhome'">취소</button>
		<button class="btn btn-primary button-right" id="signout-btn" onclick="userSignOut(this.form);" disabled>회원탈퇴</button>
		<label class="button-right">탈퇴하실 경우 복구하실 수 없습니다.</label>
	</div>
	
	</form>
	</section>

<script type="text/javascript">




function userSignOut(form){
	if(confirm("탈퇴하시겠습니까?") == true){
		
		if(${data.userPw} === document.getElementById('id_userPw').value){ 
			
	    alert("탈퇴되었습니다.");
		form.submit();
		location.href="/myhome/login"; 
			
		} else {
			alert("비밀번호가 일치하지 않습니다.");
		}
	}else{
		return false;
	}
 }

</script>


</body>
</html>