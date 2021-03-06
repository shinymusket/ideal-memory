<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 정보</title>
</head>
<body>
	<h2>상품 정보</h2>
	<table border="1">
		<tr>
			<th>상품명</th>
			<th>상품 코드</th>
			<th>가격</th>
			<th>제조사</th>
			<th>주요 원료</th>
			<th>품절 여부</th>
		</tr>
		<tr>
			<td>${product.name}</td>
			<td>${product.code}</td>
			<td>${product.price}</td>
			<td>${product.manufacturer}</td>
			<td>${product.material}</td>
			<td>${product.soldout}</td>
		</tr>
		<tr>
			<td colspan="6">
				<input type="button" value="목록으로 돌아가기" onclick="location.href='productList.jsp';">
			</td>
		</tr>
	</table>
</body>
</html>