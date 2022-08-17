<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예산 정보</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
<link type="text/css" rel="stylesheet" href="${path}/resources/css/budget/budgetInfo.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="${path}/resources/js/budget/budgetInfo.js"></script>
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>

	<article>
			<div id="title_bar">
				<p>경영 정보</p>
				<h3>예산 정보</h3>
			</div>
	
			
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<input type="button" value="목록" onclick="location.href='../budget/budget_list'">
					<table border="1">
						<tr>
							<th>예산 번호</th>
							<th>년도</th>
							<th>구분</th>
							<th>항목</th>
							<th>총액</th>
						</tr>
						<tr>
							<td>
								${budget.budget_num}	
								<input type="hidden" id="budget_num" readonly="readonly" value="${budget.budget_num}">
							</td>
							<td>${budget.budget_year}</td>
							<td>
								<c:if test="${budget.budget_iE == 'In'}">수입</c:if>
								<c:if test="${budget.budget_iE == 'Ex'}">지출</c:if>
							</td>
							<td>${budget.budget_cls}</td>
							<td>
								<fmt:formatNumber value="${budget.budget_total}" maxFractionDigits="3"/>원
							</td>
						</tr>
						<tr>
							<td colspan="5">
								<input type="button" value="삭제" id="delete">
								<input type="button" value="수정" id="update">
							</td>
						</tr>
					</table>
				</div>
			</section>
	</article>	

<%@include file="../include/footer.jsp" %>
</body>
</html>