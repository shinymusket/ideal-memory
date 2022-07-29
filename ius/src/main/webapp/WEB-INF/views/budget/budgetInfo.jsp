<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예산 정보</title>
</head>
<body>
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
			<td>${budget.budget_num}</td>
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
				<input type="button" value="삭제" onclick="location.href='../budget/budget_delete?budget_num=${budget.budget_num}'">
				<input type="button" value="수정" onclick="location.href='../budget/budget_update_form?budget_num=${budget.budget_num}'">
			</td>
		</tr>
	</table>
</body>
</html>