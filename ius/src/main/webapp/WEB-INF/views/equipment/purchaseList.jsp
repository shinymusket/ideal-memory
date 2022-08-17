<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 기록 조회</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
<link type="text/css" rel="stylesheet" href="${path}/resources/css/equipment/purchaseList.css">
<style type="text/css">
	.clickable {cursor: pointer;}
	.hover {text-decoration: underline;}
	.active{ width:10px; height:10px; background:#f60; color:white;}
</style>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="${path}/resources/js/equipment/purchaseList.js"></script>
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>
	<article>
			<div id="title_bar">
				<p>경영 정보</p>
				<h3>구매 기록 조회</h3>
			</div>
	
			
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<div id="controllBtns">
						<input type="button" value="시설(비품) 관리" onclick="location.href='../equipment/equipment_list'">
					</div>
					<div id="searchDiv">
						<select id="searchType" onchange="selSearchType()">
							<option value="purchase_num">구매 번호</option>
							<option value="finance_num">재정 코드</option>
							<option value="staff_name">구매자</option>
							<option value="equipment_num">구매 자산 번호</option>
							<option value="equipment_name">구매 자산명</option>
							<option value="purchase_date">구매 일자</option>
						</select>
						
						<input type="text" id="searchContent">
						<input type="date" id="searchDate" style="display : none;">
						<input type="button" id="searchBtn" value="검색">
					</div>
					
					<table id="purchaseList" class="tbl paginated" border="1"></table>
				</div>
			</section>
	</article>	
<%@include file="../include/footer.jsp" %>	
</body>
</html>