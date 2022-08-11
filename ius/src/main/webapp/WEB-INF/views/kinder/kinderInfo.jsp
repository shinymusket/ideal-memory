<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
 <c:set var="path" value="${pageContext.request.contextPath}"/>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>원생 정보 조회</title>
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>
	
	<article>
			<div id="title_bar">
				<p>원생 관리</p>
				<h3>원생 정보 조회</h3>
			</div>

			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<input type="button" value="목록" onclick="location.href='../kinder/kinder_list'">
					<table border="1">
						<tr>
							<th>원생 번호</th>
							<td>${kinder.kinder_num}</td>
						</tr>
						<tr>
							<th>셔틀 버스 호차</th>
							<td>${kinder.shuttle_num}</td>
						</tr>
						<tr>
							<th>담임 교사</th>
							<td>${kinder.staff_name}</td>
						</tr>
						<tr>
							<th>재원 여부</th>
							<td>${kinder.kinder_regYn}</td>
						</tr>
						<tr>
							<th>원생 이름</th>
							<td>${kinder.kinder_name}</td>
						</tr>
						<tr>
							<th>사진</th>
							<td>
								
								<img src="<spring:url value="${kinder.kinder_picture}"/>" style='width:94.4px; height:113.3px;'>
							</td>
						</tr>
						<tr>
							<th>주민등록번호</th>
							<td>${kinder.kinder_rrn1}-${kinder.kinder_rrn2}</td>
						</tr>
						<tr>
							<th>주소</th>
							<td>${kinder.kinder_addr}</td>
						</tr>
						<tr>
							<th>우편번호</th>
							<td>${kinder.kinder_zipcode}</td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td>${kinder.kinder_tel}</td>
						</tr>
						<tr>
							<th>입소일</th>
							<td>${kinder.kinder_regdate}</td>
						</tr>
						<tr>
							<th>퇴소일</th>
							<td>${kinder.kinder_retireDate}</td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="button" value="수정" onclick="location.href='../kinder/update_form_kinder?kinder_num=${kinder.kinder_num}'">
								<input type="button" value="삭제" onclick="location.href='../kinder/delete_kinder?kinder_num=${kinder.kinder_num}'">
							</td>
						</tr>
					</table>
				</div>
			</section>
	</article>	

<%@include file="../include/footer.jsp" %>	
</body>
</html>