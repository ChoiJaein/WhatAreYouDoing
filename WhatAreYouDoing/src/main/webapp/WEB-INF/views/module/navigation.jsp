<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="../module/head.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
	<title>상단바</title>
	
	<style type="text/css">
	   .logout_btn {
	   position: relative;
	   top: 27px;
	   right: 15px;
	   color: gray;
	   }
	   
	   .logo {
	   position: relative;
	   left: 15px;
	   }
	</style>
	
</head>  


    
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
   <div class="container-fluid">
		<a class="navbar-brand" href="#">
			<img class="logo" src="./static/img/wydlogo.png" onclick="location.href='/myhome/login'" alt="" height="75" style="cursor: pointer;">
		</a>
		<c:if test="${not empty sessionScope.loginData}">
			<div class="logout_btn" onclick="location.href='./logout'" style="cursor:pointer">로그아웃</div>
			<img class="logo" src="./static/img/wydlogo.png" onclick="location.href='/myhome'" alt="" height="75" style="cursor: pointer;">
		</c:if>
	</div>
</nav>


<script type="text/javascript">
 $(function(){
  $('#searchBtn').click(function() {
     window.location = "/home/board/boardList_search"
     + "?keyword="
     + encodeURIComponent($('#keywordInput').val());
     + '${pageMaker.makeQuery(1)}'
    });
 });   
 </script>

</body>
</html>