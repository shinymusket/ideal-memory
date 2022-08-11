<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정</title>
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
		});
		
		$jQ("#notice_content").summernote('enable');
		
		$jQ("#update").click(function(){
			alert("수정이 완료되었습니다.");
			$jQ("form").submit();
		});
		
		
	});
</script>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>
	<article>
			<div id="title_bar">
				<p>공지사항</p>
				<h3>공지사항 수정</h3>
			</div>
	
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<div id="notice">
						<form action="./notice_update" method="POST">
							<table border="1">
								<tr>
									<td colspan="6">
										<input type="text" id="notice_title" name="notice_title" value="${noticeInfo.notice_title}">
									</td>
								</tr>
								<tr>
									<th>글 번호</th>
									<td>
										<input type="text" id="notice_num" name="notice_num" readonly="readonly" value="${noticeInfo.notice_num}">
									</td>
									<th>작성자</th>
									<td>
										<input type="text" id="staff_name" readonly="readonly" value="${noticeInfo.staff_name}">
									</td>
									<th>작성일</th>
									<td>${noticeInfo.notice_writeDate}</td>
								</tr>	
								<tr>
									<td colspan="6">
										<textarea id="notice_content" name="notice_content">${noticeInfo.notice_content}</textarea>
									</td>
								</tr>
								<tr>
									<td colspan="6">
										<input type="button" value="수정" id="update">
										<input type="button" value="목록" onclick="location.href='../notice/notice_list'">
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