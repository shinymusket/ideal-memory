<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
<link type="text/css" rel="stylesheet" href="${path}/resources/css/notice/noticeList.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="${path}/resources/js/notice/noticeList.js"></script>
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>
	<article>
			<div id="title_bar">
				<p>그룹 웨어</p>
				<h3>공지사항</h3>
			</div>
	
			
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<div id="controllBtns">
						<input type="button" value="공지사항 등록" id="register">
					</div>
					
					<div id="searchDiv">
						<select id="searchType">
							<option value="notice_num">글 번호</option>
							<option value="notice_title">글 제목</option>
							<option value="staff_name">작성자</option>
						</select>
						<input type="text" id="searchContent">
						<input type="button" id="searchBtn" value="검색">
					</div>
					
					<div id="notice">
						<table id="noticeTbl" class="paginated" border="1"></table>
					</div>
					
				</div>
			</section>
	</article>	
<%@include file="../include/footer.jsp" %>
</body>
</html>