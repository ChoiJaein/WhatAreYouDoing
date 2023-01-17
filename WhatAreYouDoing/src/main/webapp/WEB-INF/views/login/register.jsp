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
		<c:url var="loginUrl" value="/register" />
		<form action="${loginUrl}" name="register" method="post">
			<br><br>
			<input type="hidden" name="url" value="${param.url}">
			<div class="register-box">
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
				<button class="btn btn-outline-primary bluebtn" type="submit" id="button_register" disabled>가입하기</button>
			</div>
			
			<br>
			
		</form>
	</section>


</body>
</html>