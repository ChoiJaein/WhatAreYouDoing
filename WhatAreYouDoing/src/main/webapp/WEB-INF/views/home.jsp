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
		float:left;
	}
	
/*  	section {
		min-width: 100px;
	}  */
	
 	.table-size {
	width:600px;
	height:450px;
	float:left;
	} 

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

	.userName-box {
	width:180px;
	height:180px;
	margin-left: auto;
	margin-right: auto;
	margin-top:20px;
	}
	
	.profile-box {
	margin:140px auto 0;
	background-color: rgba(250, 237, 197, 0.5);
	border-radius: 10px;
	width:220px;
	height: 330px;
	}
	
</style>
	
	
</head>
<body>
	<header>
		<%@ include file="./module/navigation.jsp" %>
	</header>
	<br><br><br>
	
	<section class="container">
	<div style="width:1250px;">
	
	<aside>
	<div class="profile-box">
		<div class="text-center">
			<img id="previewImg" class="image-360 mt-10 mb-10" alt="profile" src="<%=request.getContextPath() %>${photo.url}" 
										style="width:180px; height:180px; margin-top: 28px; border-radius: 30%;">
		</div>
		<div class="userName-box">
			<input type="text" name="userName" value="${userName}" style="border: none; background:transparent; text-align:center;" readonly>
			<div class="col text-center">
				<button class="btn btn-outline-secondary" type="button" style="margin-top:10px;" onclick="location.href='${boardUrl}modify'">내 정보</button>
			</div>
		</div>
	</div>
	</aside>
	
	<div class="table-size">
		<div class="mb-1">
		<!-- 이부분 나중에 변수값 등등(boardUrl) 수정해야 함 -->
			<c:url var="boardUrl" value="/" />
			<form action="${boardUrl}" method="get">
			<br><br><br><br><br><br>
				<div class="row g-1">
					<div class="col">
						<button class="btn btn-secondary" type="button" onclick="location.href='${boardUrl}add'">작성</button>
					</div>
					
					<%-- <div class="col-2">
						<select class="form-select" onchange="location.href='${boardUrl}?pageCount=' + this.value">
							<option value="5" ${sessionScope.pageCount == 5 ? 'selected' : ''}>5 개</option>
							<option value="10" ${sessionScope.pageCount == 10 ? 'selected' : ''}>10 개</option>
							<option value="15" ${sessionScope.pageCount == 15 ? 'selected' : ''}>15 개</option>
							<option value="20" ${sessionScope.pageCount == 20 ? 'selected' : ''}>20 개</option>
						</select>
					</div> --%>
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
		
		
		<div class="input-group" style="margin-left: 500px; width:300px;">
			<input type="text" id="keywordInput" name="keyword" class="form-control" value="${keyword}">
			<button class="btn btn-outline-secondary" type="submit" id="searchBtn">검색</button>
		</div>

		
		<nav>
			<div style="margin-top:10px;">
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
	
<script type="text/javascript">
	 $(function(){
	  $('#searchBtn').click(function() {
	     window.location = "/postList_search"
	     + "?keyword="
	     + encodeURIComponent($('#keywordInput').val());
	    });
	 });   
 </script>

</body>
</html>
