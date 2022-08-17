<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>권한 관리</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
<link type="text/css" rel="stylesheet" href="${path}/resources/css/authority/authorityEdit.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="${path}/resources/js/authority/authorityEdit.js"></script>
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>

	<article>
			<div id="title_bar">
				<p>경영 정보</p>
				<h3>권한 부여</h3>
			</div>
	
			<!-- 오른쪽 기능 박스 (검색 등등 필요없으면 div 안에 내용 지워도 무방)-->
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<div id="controllBtns">
						<input type="button" value="교직원 관리" onclick="location.href='../staff/staff_list'">
					</div>
					
					<div id="staffBox" style="float: left;">
						<table id="staffInfo" class="list" border="1">
							<tr>
								<th>교직원 코드</th>
								<th>교직원 이름</th>
								<th>교직원 아이디</th>
								<th>직무</th>
							</tr>
							
							<c:if test="${staffList != null}">
								<c:forEach items="${staffList}" var="staff">
									<tr class="bgc" onclick="getInfo(${staff.staff_num})">
										<td>${staff.staff_num}</td>
										<td>${staff.staff_name}</td>
										<td>${staff.staff_id}</td>
										<td>${staff.job_Kname}</td>
									</tr>
								</c:forEach>
							</c:if>	
						</table>		
					</div>
	
					<table id="authorityInfo" border="1" style="float: left; display: none;">
						<tr>
							<th>권한</th>
							<td>부여</td>
						</tr>
						<tr>
							<th>관리자</th>
							<td>
								<input type="checkbox" id="master">
							</td>
						</tr>
						<tr>
							<th>교사</th>
							<td>
								<input type="checkbox" id="teacher">
							</td>
						</tr>
						<tr>
							<th>급식</th>
							<td>
								<input type="checkbox" id="dietitian">
							</td>
						</tr>
						<tr>
							<th>시설</th>
							<td>
								<input type="checkbox" id="facilities">
							</td>
						</tr>
						<tr>
							<th>셔틀버스</th>
							<td>
								<input type="checkbox" id="bus">
							</td>
						</tr>
						<tr>
							<th>안내사항</th>
							<td>
								<input type="checkbox" id="info">
							</td>
						</tr>
						<tr>
							<th>행사 및 일정</th>
							<td>
								<input type="checkbox" id="event">
							</td>
						</tr>
						<tr>
							<th>갤러리</th>
							<td>
								<input type="checkbox" id="gallery">
							</td>
						</tr>
						<tr>
							<td colspan="2" id="btnsTd">
								<input type="hidden" id="staff_num">
								<input type="button" id="register" value="등록">
							</td>
						</tr>
					</table>
				</div>
			</section>
	</article> 

	
<%@include file="../include/footer.jsp" %>	
</body>
</html>