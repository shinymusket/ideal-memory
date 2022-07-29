<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index</title>
</head>
<body>
	<h1>index</h1>
	<p>${staff.staff_id}님 환영합니다.<br><a href="../main/logout">로그아웃</a></p>
	<p><a href="../finance/finance_list">재정 관리</a></p>
	<p><a href="../staff/staff_list">교직원 관리</a></p>
	<p><a href="../kinder/kinder_list">원생 관리</a></p>
	<p><a href="../equipment/equipment_list">시설 관리</a></p>
</body>
</html>