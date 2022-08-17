<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재정 코드 조회</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="${path}/resources/js/equipment/financeSelectForm.js"></script>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/equipment/financeSelectForm.css">
</head>
<body>
	<table border="1" id="financeList" class="list"></table>
</body>
</html>