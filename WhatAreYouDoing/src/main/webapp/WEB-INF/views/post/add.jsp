<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>게시글 등록</title>
	<%@ include file="../module/head.jsp" %>
	<c:url var="ckeditor" value="/static/ckeditor" />
	<script type="text/javascript" src="${ckeditor}/ckeditor.js"></script>
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
	<header></header>
	<section class="container">
		<div class="mt-3">
			<c:url var="boardAddUrl" value="/add" />
			<form action="${boardAddUrl}" method="post">
				<div class="mb-3">
					<input class="form-control" type="text" name="postTitle" value="" placeholder="제목을 입력하세요." required>
				</div>
				<div class="mb-3">
					<textarea class="form-control" name="postContent" value="" rows="8"
						placeholder="내용을 입력하세요." required></textarea>
				</div>
				<div class="mb-3">
					<input class="form-control" type="file" name="fileUpload" >
				</div>
				<div class="mb-3 text-end">
<!-- 					<button class="btn btn-primary" type="button" onclick="formCheck(this.form);">저장</button>-->					
						<button class="btn btn-primary" type="submit">저장</button>
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
						<button type="button" class="btn btn-sm btn-danger" data-bs-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
	</section>
	<footer></footer>
	<%-- <c:url var="upload" value="/upload/image" />
	<script type="text/javascript">
		CKEDITOR.replace("content", {
			filebrowserUploadUrl: "${upload}?type=image",
			filebrowserUploadMethod: 'form'
		});
	</script> --%>
	<c:url var="upload" value="/upload/image" />
	<script type="text/javascript">
		CKEDITOR.replace("postContent", {
			filebrowserUploadUrl: "${upload}?type=image"	// ck에디터가 ajax로 "" 안의 주소로 이미지를 보내줌. 이 주소로 보낸 이미지를 받아서 저장처리 해주면 됨.
		})
	</script>
</body>
</html>