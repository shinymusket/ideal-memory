<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재정 관리</title>
</head>
<body>
	<h1>재정 관리</h1>
	<c:if test="${financeList != null}">
		<table>
				<tr>
					<th>고유 번호</th>
					<th>예산 번호</th>
					<th>교직원 번호</th>
					<th>집행 날짜</th>
					<th>항목</th>
					<th>구분</th>
					<th>집행 금액</th>
				</tr>
		<c:forEach items="${financeList}" var="finance">
				<tr>
					<td>${finance.finance_num}</td>
					<td>${finance.budget_num}</td>
					<td>${finance.staff_num}</td>
					<td>${finance.finance_eDate}</td>
					<td>${finance.finance_cls}</td>
					<td>${finance.finance_iE}</td>
					<td>${finance.finance_amount}</td>
				</tr>
		</c:forEach>
		</table>
	</c:if>

</body>
</html>