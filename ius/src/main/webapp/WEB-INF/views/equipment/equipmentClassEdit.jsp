<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시설(비품) 분류 항목 편집</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="${path}/resources/js/equipment/equipmentClassEdit.js"></script>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/equipment/equipmentClassEdit.css">
</head>
<body>
	<table id="equipClsList" border="1"></table>
	<form>
		<input type="hidden" name="equip_cls_num" id="equip_cls_num">
		<input type="text" name="equip_cls_name" id="equip_cls_name" placeholder="분류 항목명">
		<input type="button" value="추가" id="insert_btn">
		<input type="button" value="수정" id="update_btn">
		<input type="button" value="삭제" id="delete_btn">
	</form>
</body>
</html>