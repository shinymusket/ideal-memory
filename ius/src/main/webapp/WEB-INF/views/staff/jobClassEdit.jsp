<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="${path}/resources/js/staff/jobClassEdit.js"></script>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/staff/jobClassEdit.css">
<title>직무 분류</title>
</head>
<body>
	<table border="1" id="jobList"></table>
	<form>
		<input type="hidden" name="staff_cls" id="staff_cls">
		<input type="text" name="job_Kname" id="job_Kname" placeholder="한글명" style="width:100px">
		<input type="text" name="job_Ename" id="job_Ename" placeholder="영문명" style="width:100px">
		<input type="button" value="추가" id="insert_btn">
		<input type="button" value="수정" id="update_btn">
		<input type="button" value="삭제" id="delete_btn">
	</form>
	
</body>
</html>