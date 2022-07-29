<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>교직원 관리</title>
</head>
<body>
	<h1>교직원 관리</h1>
	<input type="button" value="홈으로" onclick="location.href='../main/'">
	<input type="button" value="교직원 등록" onclick="location.href='../staff/staff_register'">
	<input type="button" value="권한 관리" onclick="location.href='../authority/authority_edit'">
	<input type="button" value="근태 관리" onclick="location.href='../staff_attendance/attendance_list'">
	<c:if test="${staffList != null}">
		<table border="1">
				<tr>
					<th>교직원 코드</th>
					<th>구분</th>
					<th>아이디</th>
					<th>이름</th>
					<th>성별</th>
					<th>나이</th>
					<th>생년월일</th>
					<th>주소</th>
					<th>우편번호</th>
					<th>연락처</th>
					<th>입사일</th>
					<th>퇴사일</th>
					<th>재직여부</th>
					<th>월급</th>
					<th>이메일</th>
				</tr>
		<c:forEach items="${staffList}" var="staff">
				<tr>
					<td>${staff.staff_num}</td>
					<td>${staff.job_Kname}</td>
					<td>${staff.staff_id}</td>
					<td>
						<a href="./staff_info?staff_num=${staff.staff_num}">${staff.staff_name}</a>
					</td>
					<td>${staff.staff_sex}</td>
					<td>${staff.staff_age}</td>
					<td>${staff.staff_birth}</td>
					<td>${staff.staff_addr}</td>
					<td>${staff.staff_zipcode}</td>
					<td>${staff.staff_tel}</td>
					<td>${staff.staff_hireD}</td>
					<td>${staff.staff_retireD}</td>
					<td>${staff.staff_workYn}</td>
					<td>
						<fmt:formatNumber value="${staff.staff_salary}" maxFractionDigits="3"/>
					</td>
					<td>${staff.staff_email}</td>
				</tr>
		</c:forEach>
		</table>
	</c:if>

</body>
</html>