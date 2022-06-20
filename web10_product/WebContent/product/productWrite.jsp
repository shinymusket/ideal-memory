<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록 페이지 - 관리자 페이지</title>
<link type="text/css" href="style/product.css" rel="stylesheet">
</head>
<body>
	<div id="wrap" align="center">
		<form action="productWrite" method="post" enctype="multipart/form-data">
			<table>
				<tr>
					<th>상품 명</th>
					<td><input type="text" name="name" required="required"></td>
				</tr>
				<tr>
					<th>가격</th>
					<td><input type="number" name="price" required="required">원</td>
				</tr>
				<tr>
					<th>이미지</th>
					<td><input type="file" name="pictureurl"></td>
				</tr>
				<tr>
					<th>상품 설명</th>
					<td><textarea rows="10" cols="80" name="description"></textarea></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="등록">
						<input type="reset" value="다시 작성">
						<input type="button" value="목록 돌아가기" onclick="location.href='productList';">
					</td>
				</tr>
				
			</table>
		
		
		
		</form>
	</div>
</body>
</html>