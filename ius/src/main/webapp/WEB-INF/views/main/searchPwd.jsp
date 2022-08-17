<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="${path}/resources/js/main/searchPwd.js"></script>
<link rel="stylesheet" href="${path}/resources/css/searchPwd.css">
</head>
<body>
	<div id="container">
		<ul>
			<li>계정 가입시 입력한 이메일을 입력해주세요.</li>
		</ul>
		<input type="text" id="staff_email" autocomplete="off">
		<input type="button" value="찾기" id="search">
		<br>
		<font id="check" size="2"></font>
	</div>
	
</body>
</html>