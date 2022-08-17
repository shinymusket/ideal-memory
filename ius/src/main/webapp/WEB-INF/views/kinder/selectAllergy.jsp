<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알러지 정보 입력</title>
<link rel="stylesheet" href="${path}/resources/css/allergy.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="${path}/resources/js/kinder/selectAllergy.js"></script>
</head>
<body>
<input type="hidden" value="<c:if test="${allergy_code != 0}">${allergy_code}</c:if>" id="allergy_code">
<form name="allergy">
	<div id="allergy_box">
		<ul>
			<li>
				<input type="checkbox" id="na">알러지 없음
			</li>
			<li>
				<input type="checkbox" id="a1">난류(가금류)
			</li>
			<li>
				<input type="checkbox" id="a2">우유
			</li>
			<li>
				<input type="checkbox" id="a3">메밀
			</li>
			<li>
				<input type="checkbox" id="a4">땅콩
			</li>
			<li>
				<input type="checkbox" id="a5">대두
			</li>
			<li>
				<input type="checkbox" id="a6">밀
			</li>
			<li>
				<input type="checkbox" id="a7">고등어
			</li>
			<li>
				<input type="checkbox" id="a8">게
			</li>
			<li>
				<input type="checkbox" id="a9">새우
			</li>
			<li>
				<input type="checkbox" id="a10">돼지고기
			</li>
			<li>
				<input type="checkbox" id="a11">복숭아
			</li>
			<li>
				<input type="checkbox" id="a12">토마토
			</li>
			<li>
				<input type="checkbox" id="a13">아황산염
			</li>
			<li>
				<input type="checkbox" id="a14">호두
			</li>
			<li>
				<input type="checkbox" id="a15">닭고기
			</li>
			<li>
				<input type="checkbox" id="a16">쇠고기
			</li>
			<li>
				<input type="checkbox" id="a17">오징어
			</li>
			<li>
				<input type="checkbox" id="a18">조개류
			</li>
		</ul>
		<div id="but_box">
			<input type="button" value="확인" id="register">
		</div>
	</div>
</form>
</body>
</html>