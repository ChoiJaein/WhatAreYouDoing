<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>${data.postTitle}
	</title>
	<%@ include file="../module/head.jsp" %>
	
	<style type="text/css">
	.container {
	 padding: 10px 20px 10px; 
	 margin: 70px auto; 
	 min-width: 900px;
	 background-color: lightgray; 
	 border-radius: 0.5%;"
	}
	
	h2 {
	color: #474848;
	}
	
	p{
	color: #474848;
	}
	
	</style>
	
</head>

<body>
	<header>
		<%@ include file="../module/navigation.jsp" %>
	</header>
	
	<section class="container" style="width:900px;">
		<div>
			<div style="margin-top: 10px; min-widht: 800px; min-height: 43px; background-color:white; border-radius: 2%;">
				<h2>${data.postTitle}</h2>
			</div>
			<div class="mb-1" style="text-align:right; margin-top:20px; color: #FFF9E6;">
				<fmt:formatDate value="${data.postDate}" var="postDate" dateStyle="long" />
				<label class="pe-3">${postDate}</label>
			</div>
			<div class="mb-1" style="min-height: 600px; padding:1px 20px; background-color: white; border-radius: 1%;">
				<p>${data.postContent}</p>
			</div>
			
			
			<c:url var="boardUrl" value="/" />		<!-- c:url로 contextPath를 자동으로 포함한 url 생성해줌. contextPath에 /board 라는 값을 포함해서 url 생성한 후 boardUrl 변수에 담아서 사용 -->
			<div class="row">
			<div class="col-6 mt-2 text-start ">
				<button class="btn btn-outline-secondary" type="button" onclick="location.href='${boardUrl}'">목 록</button>
			</div>
			<div class="col-6 mt-2 text-end">
				<button class="btn btn-outline-danger" type="button" data-bs-toggle="modal" data-bs-target="#removeModal">삭 제</button>			<!-- 이 버튼 누르면 removeModal(130번째 줄)이 실행됨 -->
				<button class="btn btn-outline-secondary" type="button" onclick="location.href='${boardUrl}postMod?postId=${data.postId}'">수 정</button>	<!-- 여기서 boardUrl 사용. 여기서 data.id는 상세 글 번호. 여기서 이동하는 /modify에 대한 메소드는 BoardController에 있음. -->
			</div>
			</div>
		</div>


					<!-- 57번줄에서 삭제버튼(게시글 상세화면의 삭제버튼) 누르면 이 모달이 실행됨. -->
		<div class="modal fade" id="removeModal" tabindex="-1" aria-hidden="true">	
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h6 class="modal-title">삭제 확인</h6>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						이 게시물을 삭제하시겠습니까?
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-sm btn-danger" data-bs-dismiss="modal" onclick="deleteBoard(${data.postId})">확 인</button>	<!-- 확인 누르면 deleteBoard메소드(220번째 줄)가 실행됨. 인자로 게시글 번호(data.id)전달. -->
					</div>
				</div>
			</div>
		</div>
	</section>
	<footer></footer>
	<script type="text/javascript">
		function changeEdit(element) {
			element.innerText = "확인";
			element.nextElementSibling.remove();
			
			var value = element.parentElement.previousElementSibling.innerText;
			var textarea = document.createElement("textarea");
			textarea.setAttribute("class", "form-control");
			textarea.value = value;
			
			element.parentElement.previousElementSibling.innerText = "";
			element.parentElement.previousElementSibling.append(textarea);
			
			element.setAttribute("onclick", "commentUpdate(this);");
		}
		
		function changeText(element) {
			element.innerText = "수정";
			var cid = element.parentElement.parentElement.children[0].value;
			var value = element.parentElement.previousElementSibling.children[0].value;
			element.parentElement.previousElementSibling.children[0].remove();
			element.parentElement.previousElementSibling.innerText = value;
			
			var btnDelete = document.createElement("button");
			btnDelete.innerText = "삭제";
			btnDelete.setAttribute("class", "btn btn-sm btn-outline-dark");
			btnDelete.setAttribute("onclick", "commentDelete(this, " + cid + ");");
			
			element.parentElement.append(btnDelete);
			element.setAttribute("onclick", "changeEdit(this);");
		}
		
		/* function commentUpdate(element) {
			var cid = element.parentElement.parentElement.children[0].value;
			var value = element.parentElement.previousElementSibling.children[0].value;
			
			$.ajax({
				url: "/comment/modify",
				type: "post",
				data: {
					id: cid,
					content: value
				},
				success: function(data) {
					element.parentElement.previousElementSibling.children[0].value = data.value
					changeText(element);
				}
			});
		}
		
		function commentDelete(element, id) {
			$.ajax({
				url: "/comment/delete",
				type: "post",
				data: {
					id: id
				},
				success: function(data) {
					if(data.code === "success") {
						element.parentElement.parentElement.parentElement.parentElement.remove();
					}
				}
			});
		}
		function formCheck(form) {
			if(form.content.value.trim() === "") {
				alert("댓글 내용을 입력하세요.");
			} else {
				form.submit();
			}
		} */
		function deleteBoard(postId) {
			$.ajax({						// ajax로
				url: "/delete",	// url주소 요청. 53번째줄에서 c:url로 contextPath+/board를 boardUrl에 넣어놓았기 때문에 그대로 사용.
				type: "post",				// 메소드는 post
				data: {						// 전달하는 데이터는 postId
					 postId: ${data.postId}	
				},
				dataType: "json",
				success: function(data) {
					if(data.code === "success") {	// 삭제가 완료되면
						alert("삭제 완료");			// 알람으로 삭제 완료 띄움
						location.href="/";
					} else if(data.code === "notExists") {		// 해당 데이터(=글)가 존재하지 않으면
						alert("이미 삭제되었습니다.");
					}
				}
			});
		}
/* 		 function ajaxLike(element, id) {
			$.ajax({
				type: "post",
				url: "${boardUrl}/like",
				data: {
					id: id
				},
				success: function(data) {	
					if(data.code === "success") {	// controller에서 전송한 code의 값이 success이면 data.like라는 형태로 json 정보를 받음
						element.innerText = data.like;
					} else if(data.code === "noData") {	// controller에서 전송한 code 값이 noData이면 값을 넣은 message 알람 띄우고 게시판으로 이동시킴
						alert(data.message);
						location.href = "${boardUrl}";	
					}
				}
			});
		}  */
	</script>
</body>
</html>