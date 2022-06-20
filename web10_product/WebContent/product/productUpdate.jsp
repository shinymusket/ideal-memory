<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정 페이지 - 관리자 페이지</title>
<link type="text/css" href="style/product.css" rel="stylesheet">
</head>
<body>
	<div id="wrap" align="center">
		<h1>상품 수정 페이지 - 관리자</h1>
			<form action="productUpdate" method="post" enctype="multipart/form-data">
				<table>
					<tr>
						<td rowspan="4">
							<c:choose>
								<c:when test="${empty productVO.pictureurl}">
									<img alt="이미지 없음" src="/images/noimage.jpg">
								</c:when>
								<c:otherwise>
									<img alt="상품 이미지" src="/images/${productVO.pictureurl}">
								</c:otherwise>
							</c:choose>
							<input type="hidden" name="code" value="${productVO.code}">
						</td>
						<th>상품명</th>
						<td><input type="text" name="name" value="${productVO.name}"></td>
					</tr>
					
					<tr>
						<th>가격</th>
						<td><input type="number" name="price" value="${productVO.price}">원</td>
					</tr>
					
					<tr>
						<th>이미지</th>
						<td>
							<input type="file" name="pictureurl"> <br>
							(주의사항 : 이미지를 변경하고자 할 때만 선택하세요.)
							<input type="hidden" name="originPicureUrl" value="${productVO.pictureurl}"> 
						</td>
					</tr>
					
					<tr>
						<th>설명</th>
						<td><textarea rows="10" cols="80" name="description">${productVO.description}</textarea></td>
					</tr>
					<tr>
						<td colspan="3">
							<input type="submit" value="수정">
							<input type="reset" value="다시 작성">
							<input type="button" value="목록 돌아가기" onclick="location.href='productList';">
						</td>
					</tr>
						
				</table>	
			</form>
		
	</div>
</body>
</html>