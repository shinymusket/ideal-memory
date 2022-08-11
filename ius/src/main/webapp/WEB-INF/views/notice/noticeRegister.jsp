<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 등록</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="${path}/resources/js/summernote/summernote-lite.js"></script>
<script type="text/javascript" src="${path}/resources/js/summernote/lang/summernote-ko-KR.js"></script>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/summernote/summernote-lite.css">
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css?">
</head>
<style>
	#notice_title {
		height : 30px;
	 	width : 1238px;
	 	padding-left : 10px;
	 	margin-bottom : 10px;
	}
	
	#register {
		display : inline-block;
		width : 50px;
		margin: 5px auto;
	}
</style>
<body>
<script type="text/javascript">
	var $jQ = jQuery.noConflict();
	$jQ(document).ready(function(){
		$jQ("#notice_content").summernote({
			height : 300,
			width : 1238,
			minHeight : null,
			maxHeight : null,
			focus : true,
			lang : "ko-KR",
			placeholder : '내용을 입력하세요'
		});
		
		$jQ("#register").click(function(){
			var notice_title =  $jQ("#notice_title").val();
			var notice_content = $jQ("#notice_content").val();
			
			if (notice_title == "") {
				alert("제목을 입력해주세요.");
				return;
			};
			
			if (notice_content == "") {
				alert("내용을 입력해주세요.");
				return;
			};
			
			alert("정상적으로 글이 등록 되었습니다.");
			$jQ("form").submit();
			
		});
	
		
			
	});
</script>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>
	<article>
			<div id="title_bar">
				<p>공지사항</p>
				<h3>공지사항 등록</h3>
			</div>
	
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<div id="notice">
						<form action="./notice_register" method="POST">
							<table border="1">
								<tr>
									<th>
										<input type="hidden" id="staff_id" name="staff_id" value="${staff_id}">
										<input type="text" id="notice_title" name="notice_title" placeholder="제목">
									</th>
								</tr>
								<tr>
									<td>
										<textarea id="notice_content" name="notice_content"></textarea>
									</td>
								<tr>
								<tr>
									<td>
										<input type="button" value="등록" id="register">
									</td>
								</tr>
							</table>
						</form>
					</div>
				</div>
			</section>
	</article>	

<%@include file="../include/footer.jsp" %>
</body>

</html>