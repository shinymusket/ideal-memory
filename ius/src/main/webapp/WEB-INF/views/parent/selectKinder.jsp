<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="${path}/resources/js/parent/selectKinder.js"></script>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/parent/selectKinder.css">
<title>원생 조회</title>
</head>
<body>
	<input type="text" id="kinder_name" placeholder="원생 명을 입력하세요.">
	<input type="button" value="조회" id="search">
	
	<table id="kinderList" border="1"></table>
</body>
</html>