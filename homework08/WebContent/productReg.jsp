<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록 페이지</title>
</head>
<body>
	<h2>상품 등록 페이지</h2>
	<table border="1">
		<form action="PRS" method="post">
			<tr>
				<td>상품명</td>
				<td>
					<input type="text" name="name">
				</td>
			</tr>
			<tr>
				<td>상품 코드</td>
				<td>
					<input type="text" name="code">
				</td>
			</tr>
			<tr>
				<td>가격</td>
				<td>
					<input type="number" name="price">
				</td>
			</tr>
			<tr>
				<td>제조사</td>
				<td>
					<input type="text" name="manufacturer">
				</td>
			</tr>
			<tr>
				<td>주요 원료</td>
				<td>
					<input type="text" name="material">
				</td>
			</tr>
			<tr>
				<td>품절 여부</td>
				<td>
					<input type="radio" name="soldout" value="N" checked>N
					<input type="radio" name="soldout" value="Y">Y
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="등록">
					<input type="reset" value="취소">
				</td>
			</tr>
		</form>
	</table>	
</body>
</html>