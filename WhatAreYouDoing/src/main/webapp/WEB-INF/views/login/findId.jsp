<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<title>아이디 찾기 성공</title>
    <%@ include file="../module/head.jsp" %> 
</head>
<body>
<header>
	<%@ include file="../module/navigation.jsp" %>
</header>
<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<div class="w3-center w3-large w3-margin-top">
				<h3>아이디 찾기 검색결과</h3>
			</div>
			<div>
			 	<div align ="center">
				 <c:if test="${not empty sessionScope.emailData}">	
				회원님의 아이디는	${ emailData.userId } 입니다.
				  </c:if>	
					<div class="form-label-group">
					<div class ="center-cancel ">
					<button type="button" onclick= "location.href='/login'" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">확인</button>
					<button type="button" onclick="history.go(-1);" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">돌아가기</button>
					</div>
			   </div>
		</div>
	</div>
</body>
</html>