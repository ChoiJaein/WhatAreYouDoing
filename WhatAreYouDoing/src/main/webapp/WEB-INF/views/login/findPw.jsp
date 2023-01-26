<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<head>
	<meta charset="UTF-8">
	<title>아이디 / 비밀번호 찾기</title>
	<%@ include file="../module/head.jsp" %>
</head>
<body>
<header>
	<%@ include file="../module/navigation.jsp" %>
	</header>
  <section>
   	<title>비밀번호 찾기</title>
    <header class="mb-3"></header>
        <c:url var="find_pwUrl" value="/findPw"/>
		<form action="${find_pwUrl}" method="post" >
	    <div align="center">   
		<p id ="title" name = "title" align ="center"></p> 
		<h2>비밀번호 찾기</h2>
		<p>가입하신 아이디와 이메일 주소를 입력하세요.</p>
	      
			<div>
				<p>
					<label>아이디</label>
					<input class="w3-input" type="text" id="userId" name="userId" placeholder="회원가입한 아이디를 입력하세요" required>
				</p>
				<p>
					<label>이메일</label>
					<input class="w3-input" type="text" id="userEmail" name="userEmail" placeholder="회원가입한 이메일주소를 입력하세요" required>
				</p>
				<p class="w3-center">
					<button type="button" id="findBtn" class="w3-button w3-hover-white w3-ripple w3-margin-top w3-round mybtn">찾기</button>
					<button type="button" onclick="history.go(-1);" class="w3-button w3-hover-white w3-ripple w3-margin-top w3-round mybtn">이전 화면</button>
				</p>
			</div>


        </div>
     </div>
  </form>
 </section>
</body>

<script type="text/javascript">
	$(function(){
		$("#findBtn").click(function(){
			$.ajax({
				url : "/findPw",
				type : "POST",
				data : {
					userId : $("#userId").val(),
					userEmail : $("#userEmail").val()
				},
				success : function(result) {
					alert(result);
				},
			})
		});
	})
</script>
</html>




