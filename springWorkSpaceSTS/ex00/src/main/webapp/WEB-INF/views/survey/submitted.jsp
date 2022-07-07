<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>응답 내용</title>
</head>
<body>
	<h2>응답 내용</h2>
	<ul>
		<c:forEach items="${ansData.responses}" var="response" varStatus="status">
			<li>${status.index + 1}번 문항 : ${response}</li>
		</c:forEach>
	</ul>
	
	<p>응답자 위치 : ${ansData.res.location}</p>
	<p>응답자 나이 : ${ansData.res.age}</p>
</body>
</html>