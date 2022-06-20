<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록 페이지</title>
</head>
<body>
	<h2>상품 목록 페이지</h2>
	<table border="1">
		<tr>
			<th>상품명</th>
			<th>상품 코드</th>
		</tr>
 	
 	<c:forEach items="${productList}" var="product">
 		<tr>
 			<td><a href="PIS?code=${product.code}">${product.name}</a></td>
 			<td>${product.code}</td>
 		</tr>
 	</c:forEach>
		<tr>
			<td colspan="2">
				<input type="button" value="상품 등록" onclick="location.href='productReg.jsp';">
			</td>
		</tr>
		
	
	</table>
</body>
</html>