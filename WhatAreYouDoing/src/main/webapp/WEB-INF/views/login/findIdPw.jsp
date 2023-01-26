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
   <c:url var="find_idUrl" value="/findId"/>
   <form action="${find_idUrl}" method="post">
   <div align="center">
	  <p id ="title" name = "title" align ="center"></p> 
		<h2>아이디 찾기</h2>
		<p>가입시 사용한 이메일 주소를 입력하세요.</p>
		  <table>
		  <tr><td>
	          <input class="form-control" placeholder="이메일"  id="userEmail" name="email" size=50px;>
	       <br><br> 
	      </td></tr>    
    <div class="form-label-group">
       <br>
       <br>
        <tr><td>
	          <div align="center">
	            <button type="submit" class="btn btn-outline-primary bluebtn"  id="findId_btn"  value="check" >아이디 찾기</button> <br><br>
	            <button type="button" class="btn btn-outline-primary bluebtn"  id="reset" onclick="location.href='/login'" value="취소" >취소</button> <br><br>
			  </div>
	    </td></tr>
 	</div>
  </div>
 </table>
  </form>
 </section>
</body>

</html>




