<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 영화 정보 페이지</title>
<link type="text/css" href="style/movie_info.css" rel="stylesheet">
</head>
<body>
	<div id="wrap" align="center">
		<h2>상세 영화 정보</h2>
		<table border="2">
			<tr>
				<th>영화 제목</th>
				<th>영화 감독</th>
				<th>주연 배우</th>
				<th>가격</th>
				<th>스틸컷</th>
				<th>평점</th>
			</tr>
			<tr>
				<td>${movie.movieName}</td>
				<td>${movie.movieDirector}</td>
				<td>${movie.leadingActor}</td>
				<td>${movie.moviePrice}</td>
				<td>
					<img src="/images/${movie.stillCutPath}" alt="stillCut">
				</td>
				<td>${movie.grade}</td>
			</tr>
			<tr>
				<td colspan="6">
					<input type="button" onclick="location.href='MD?movieCode=${movie.movieCode}';" value="삭제"> 
					<input type="button" onclick="location.href='MA?movieCode=${movie.movieCode}';" value="수정"> 
					<input type="button" onclick="location.href='MLS'" value="목록으로 돌아가기">
				</td>
			</tr>
		</table>
	</div>
</body>
</html>