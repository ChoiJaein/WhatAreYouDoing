<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>게시글 수정 - ${data.postTitle}</title>
	<%@ include file="../module/head.jsp" %>
	<c:url var="ckeditor" value="/static/ckeditor" />
	<script type="text/javascript" src="${ckeditor}/ckeditor.js"></script>
	
	<style type="text/css">
	.container {
	 padding: 10px 20px 10px; 
	 margin: 70px auto; 
	 min-width: 900px;
	 background-color:lightgray; 
	 border-radius: 2%;"
	}
	</style>
	
</head>
<script type="text/javascript">
	function formCheck(form) {
		if(form.postTitle.value === undefined || form.postTitle.value.trim() === "") {			/* title값(title.value)이 비어있으면(title.value.trim() === "") */
			var modal = new bootstrap.Modal(document.getElementById("errorModal"), {	/* title 채워라는 에러메세지가 뜨게 함 */
				keyboard: false
			});
			modal.show();
			return;
		}						/* title에 적절한 값이 들어있다면  */
		form.submit();			/* 저장요청할 수 있게 전송(submit)해라. 이때 전송은 "/board/modify"로 하고 메소드는 "post"로 함. -> BoardController의 @PostMapping으로 이동*/
	}
</script>
<body>
	<header>
		<%@ include file="../module/navigation.jsp" %>
	</header>
	
	<section class="container" style="width:900px;">
		<div class="mt-3">
			<c:url var="boardModifyUrl" value="/postMod" />		<!-- BoardController의 @GetMapping(value="/modify")에서 여기로 이동함.-->
			<form action="${boardModifyUrl}" method="post">				<!--  그리고 수정요청 완료 후 저장(js까지 완료)시 다시 BoardController의 @PostMapping으로 이동.  -->
				<input type="hidden" name="postId" value="${data.postId}">		<!-- 전달받은 id값(수정 원하는 게시글 번호) 전달, 숨겨져있음 -->
				<div class="mb-3">
					<input class="form-control" type="text" name="postTitle" value="${data.postTitle}" placeholder="제목을 입력하세요.">	<!-- 초기값 제공, 제목 수정 -->
				</div>
				<div class="mb-3">
					<textarea class="form-control" name="postContent" rows="8"
						placeholder="내용을 입력하세요.">${data.postContent}</textarea>			<!-- 초기값 제공, 내용 수정 -->
				</div>
				<div class="mb-2 text-end">
					<button class="btn btn-outline-secondary" type="button" onclick="formCheck(this.form);">저 장</button>		<!-- formCheck라는 js를 이용해서 저장 -->
				</div>
			</form>
		</div>

		<div class="modal fade" id="errorModal" tabindex="-1" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h6 class="modal-title">입력 오류</h6>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						제목은 공란을 입력할 수 없습니다.<br>
						반드시 제목을 입력하세요.
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-sm btn-danger" data-bs-dismiss="modal">확 인</button>
					</div>
				</div>
			</div>
		</div>
	</section>
	<footer></footer>
	<c:url var="upload" value="/upload/image" />
	<script type="text/javascript">
		CKEDITOR.replace("postContent", {
			filebrowserUploadUrl: "${upload}?type=image"	// ck에디터가 ajax로 "" 안의 주소로 이미지를 보내줌. 이 주소로 보낸 이미지를 받아서 저장처리 해주면 됨.
		})
	</script>
</body>
</html>