<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 정보 수정 페이지</title>
<link type="text/css" href="style/movie.css" rel="stylesheet">
</head>
<body>
	<div id="wrap" align="center">
		<h2>영화 정보 수정</h2>
		<table>
			<form action="MA" method="post" enctype="multipart/form-data">
				<tr>
					<th>
						<label for="MovieName">영화 이름 :</label>
					</th>
					<td>
						<input type="text" id="MovieName" name="MovieName" value="${movie.movieName}">
						<input type="hidden" name="MovieCode" value="${movie.movieCode}">
					</td>
				</tr>
				<tr>
					<th>
						<label for="MovieDirector">영화 감독 :</label>
					</th>
					<td>
						<input type="text" id="MovieDirector" name="MovieDirector" value="${movie.movieDirector}">
					</td>
				</tr>
				<tr>
					<th>
						<label for="LeadingActor">주연 배우 :</label>
					</th>
					<td>
						<input type="text" id="LeadingActor" name="LeadingActor" value="${movie.leadingActor}">
					</td>
				</tr>
				<tr>
					<th>
						<label for="MoviePrice">가격 :</label>
					</th>
					<td>
						<input type="text" id="MoviePrice" name="MoviePrice" value="${movie.moviePrice}">
					</td>
				</tr>
				<tr>
					<th>
						<label for="StillCutPath">스틸 컷 :</label>
					</th>
					<td>
						<input type="file" id="StillCutPath" name="StillCutPath">
						<input type="hidden" name="OriginStillCutPath"  value="${movie.stillCutPath}">
					</td>
				</tr>
				<tr>
					<th>
						<label for="grade">영화 등급 :</label>
					</th>
					<td>
						<input type="number" step="0.01" min="1" max="10" id="grade" name="grade" value="${movie.grade}">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="hidden" name="MovieCode" value="${movie.movieCode}">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="등록">
						<input type="button" value="목록으로 가기" onclick="location.href='MLS'">
					</td>
				</tr>
				
			</form>
		</table>
	</div>
</body>
</html>