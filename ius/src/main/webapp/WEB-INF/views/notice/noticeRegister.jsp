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
<script type="text/javascript" src="${path}/resources/js/notice/noticeRegister.js"></script>
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
	
	input[type="button"] {
		padding : 3px;
	}
	
	#controllBtns {
		margin-bottom : 10px;
	}
	
	#registerBtnTd {
		text-align : center;
	}
	
	table, th, td, tr {
		border: 1px solid #ccc;
		border-collapse: collapse;
		padding : 7px;
	}
	
	
	th {
		background-color: #486890;
		color: white;
	}
</style>
<body>
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
					<div id="controllBtns">
						<input type="button" value="목록" onclick="location.href='../notice/notice_list'">						
					</div>
				
					<div id="notice">
						<form action="./notice_register" method="POST">
							<table border="1">
								<tr>
									<th>제목</th>
								</tr>
								<tr>
									<td>
										<input type="hidden" id="staff_id" name="staff_id" value="${staff_id}">
										<input type="text" id="notice_title" name="notice_title" placeholder="제목을 입력하세요.">
									</td>
								</tr>
								<tr>
									<td>
										<textarea id="notice_content" name="notice_content"></textarea>
									</td>
								<tr>
								<tr>
									<td id="registerBtnTd">
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