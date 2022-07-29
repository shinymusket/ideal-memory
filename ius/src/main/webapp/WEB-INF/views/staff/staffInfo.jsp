<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>교직원 정보</title>
</head>
<body>
	<h1>교직원 정보</h1>
	<input type="button" value="홈으로" onclick="location.href='../main/'">
	<input type="button" value="목록으로" onclick="location.href='./staff_list'">
	<input type="button" value="정보 수정" onclick="location.href='./staff_update_form?staff_num=${staff.staff_num}'">
	<input type="button" value="삭제" onclick="location.href='./staff_delete?staff_num=${staff.staff_num}'">
	<table border="1">
			<tr>
				<th>교직원 코드</th>
				<td>
					${staff.staff_num}
				</td>
				<th>구분</th>
				<td>
					${job.job_Kname}
				</td>
			</tr>
			<tr>
				<th>아이디</th>
				<td>
					${staff.staff_id}
				</td>
				<th>이름</th>
				<td>
					${staff.staff_name}
				</td>
			</tr>
			<tr>
				<th>주민등록번호</th>
				<td>
					${staff.staff_rrn1}-${staff.staff_rrn2}
				</td>
				<th>주소</th>
				<td>
					${staff.staff_addr}
				</td>
			</tr>
			<tr>
				<th>우편번호</th>
				<td>
					${staff.staff_zipcode}
				</td>
				<th>연락처</th>
				<td>
					${staff.staff_tel}
				</td>
			</tr>
			<tr>
				<th>입사일</th>
				<td>
					${staff.staff_hireD}
				</td>
				<th>퇴사일</th>
				<td>
					${staff.staff_retireD}
				</td>
			</tr>
			<tr>
				<th>재직여부</th>
				<td>
					${staff.staff_workYn}
				</td>
				<th>월급</th>
				<td>
					${staff.staff_salary}
				</td>
			</tr>
			<tr>
				<th colspan="2">이메일</th>
				<td colspan="2">
					${staff.staff_email}
				</td>
			</tr>
		</table>
</body>
</html>