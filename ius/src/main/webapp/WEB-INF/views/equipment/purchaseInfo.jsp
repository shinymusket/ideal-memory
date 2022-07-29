<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 정보</title>
</head>
<body>
	<h1>구매 정보</h1>
	<input type="button" value="구매 목록" onclick="location.href='../equipment/purchase_list'">
	
	<table border="1">
		<tr>
			<th colspan="2">구매 번호</th>
			<td colspan="2">
				${purchase.purchase_num}
			</td>
		</tr>
		<tr>
			<th>재정 코드</th>
			<td>${purchase.finance_num}</td>
			<th>재정 항목</th>
			<td>${purchase.finance_cls}</td>
		</tr>
		<tr>
			<th colspan="2">구매자</th>
			<td colspan="2">
				${purchase.staff_name}
			</td>
		</tr>
		<tr>
			<th>구매 자산 번호</th>
			<td>${purchase.equipment_num}</td>
			<th>구매 자산 명</th>
			<td>${purchase.equipment_name}</td>
		</tr>
		<tr>
			<th colspan="2">구매 일자</th>
			<td colspan="2">${purchase.purchase_date}</td>
		</tr>
		<tr>
			<th>구매 가격</th>
			<td>
				<fmt:formatNumber value="${purchase.purchase_price}" maxFractionDigits="3"/>	
			</td>
			<th>구매 수량</th>
			<td>${purchase.purchase_count}</td>
		</tr>
		<tr>
			<td colspan="4">
				<input type="button" value="수정" onclick="location.href='../equipment/purchase_update_form?purchase_num=${purchase.purchase_num}'">
				<input type="button" value="삭제" onclick="location.href='../equipment/purchase_delete?purchase_num=${purchase.purchase_num}'">
			</td>
		</tr>
		
		
	</table>
</body>
</html>