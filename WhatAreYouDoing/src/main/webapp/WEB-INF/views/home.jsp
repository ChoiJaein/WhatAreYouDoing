<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>메인페이지</title>
	<%@ include file="./module/head.jsp" %>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
	
	<style type="text/css">
	
	aside {
		width:360px;
		height:450px;
		margin: 0 auto;
		background-color: skyblue;
		float:left;
	}
	
/*  	section {
		min-width: 100px;
	}  */
	
 	.table-size {
	width:600px;
	height:450px;
		background-color: pink;
		float:left;
	} 
	</style>
	<style>
	.page-link {
  color: #000; 
  background-color: #fff;
  border: 1px solid #ccc; 
}

.page-item.active .page-link {
 z-index: 1;
 color: #555;
 font-weight:bold;
 background-color: #f1f1f1;
 border-color: #ccc;
 
}

.page-link:focus, .page-link:hover {
  color: #000;
  background-color: #fafafa; 
  border-color: #ccc;
}
	
	</style>
	
	
</head>
<body>
	<header>
		<%@ include file="./module/navigation.jsp" %>
	</header>
	<br><br><br>
	
	<section class="container" style="background-color: orange">
	<div style="width:1250px;">
	<aside>ASIDE</aside>
	<div class="table-size">
		<div class="mb-1">
		<!-- 이부분 나중에 변수값 등등(boardUrl) 수정해야 함 -->
			<c:url var="boardUrl" value="/" />
			<form action="${boardUrl}" method="get">
			<br><br><br><br><br><br>
				<div class="row g-1">
					<div class="col-10">
						<button class="btn btn-secondary" type="button" onclick="location.href='${boardUrl}add'">추가</button>
					</div>
					
					<div class="col-2">
						<select class="form-select" onchange="location.href='${boardUrl}?pageCount=' + this.value">
							<option value="5" ${sessionScope.pageCount == 5 ? 'selected' : ''}>5 개</option>
							<option value="10" ${sessionScope.pageCount == 10 ? 'selected' : ''}>10 개</option>
							<option value="15" ${sessionScope.pageCount == 15 ? 'selected' : ''}>15 개</option>
							<option value="20" ${sessionScope.pageCount == 20 ? 'selected' : ''}>20 개</option>
						</select>
					</div>
				</div>
			</form>
		</div>
		
		
		<table class="table table-hover">
			<colgroup>
				<col class="col-1">
				<col class="col-auto">
				<col class="col-3">
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성일</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${not empty datas}">
					<c:forEach items="${datas}" var="data">
						<c:url var="boardDetailUrl" value="/detail">	<!-- c:url로 board/detail 경로에 대해서 -->
							<c:param name="postId">${data.postId}</c:param>			<!-- id파라미터 id값으로 -->
						</c:url>
						<tr onclick="location.href='${boardDetailUrl}'">	<!-- tr태그자체가 클릭이 되면 ''안 주소로 이동 -->
							<td>${data.postId}</td>
							<td>${data.postTitle}</td>
							<td>${data.postDate}</td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
		</div>
		
		
		<div class="input-group" style="margin-left: 340px; width:300px;">
			<input type="text" name="search" class="form-control" aria-describedby="button-addon2">
			<button class="btn btn-outline-secondary" type="submit" id="button-addon2">조회</button>
		</div>

		
		<nav>
			<div>
				<ul class="pagination justify-content-center">
					<c:if test="${pageData.hasPrevPage()}">
						<li class="page-item">
							<a class="page-link" href="${boardUrl}?page=${pageData.prevPageNumber}"aria-label="Previous">
								<span aria-hidden="true">&laquo;</span>
							</a>
						</li>
					</c:if>
					<c:forEach items="${pageData.getPageNumberList(pageData.currentPageNumber - 2, pageData.currentPageNumber + 2)}" var="num">
						<li class="page-item ${pageData.currentPageNumber eq num ? 'active' : ''}">
							<a class="page-link" href="${boardUrl}?page=${num}">${num}</a>
						</li>
					</c:forEach>
					<c:if test="${pageData.hasNextPage()}">
						<li class="page-item">
							<a class="page-link" href="${boardUrl}?page=${pageData.nextPageNumber}"aria-label="Next">
								<span aria-hidden="true">&raquo;</span>
							</a>
						</li>
					</c:if>
				</ul>
			</div>
		</nav>
	</div>
	</section>
	
<footer>	
	
</footer>

</body>
</html>
