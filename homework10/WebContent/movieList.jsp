<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 목록 페이지</title>
<link type="text/css" href="style/movie.css" rel="stylesheet">
</head>
<body>
	<div id="wrap" align="center">
		<h2>영화 목록 페이지</h2>
		
		
		<table border="2">
			<tr>
				<th>번호</th>
				<th>영화 제목</th>
				<th>주연 배우</th>
				<th>평점</th>
			</tr>
			
			<c:forEach items="${movieList}" var="movie" varStatus="status">
				<tr>
					<td>${status.count}</td>
					<td><a href="MIS?movieCode=${movie.movieCode}">${movie.movieName}</a></td>
					<td>${movie.leadingActor}</td>
					<td>${movie.grade}</td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="4" align="right">
					<button type ="button" onclick="location.href='MR';">영화 등록</button>
				</td>
			</tr>
			
		</table>
	</div>	
</body>
</html>