<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<title>셔틀버스 관리</title>
<link rel="stylesheet" href="${path}/resources/css/articleF.css">
<link rel="stylesheet" href="${path}/resources/css/shuttle/shuttleList.css">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="${path}/resources/js/shuttle/shuttleList.js"></script>
</head>
<body>
<%@include file="../include/header.jsp"%>
<%@include file="../include/nav.jsp"%>
	<article>
		<!-- 왼쪽 소제목 박스 -->
		<div id="title_bar">
			<p>경영 정보</p>
			<h3>셔틀버스 관리</h3>
		</div>

		<!-- 오른쪽 기능 박스 (검색)-->
		<div id="title_top">
			
		</div>

		<!-- 내용 구간 -->
		<!-- 내용 넣으면 길이 알아서 늘어나요(아마도) -->
		<section>
			<div id="content">
				<div id="controllBtns">
					<input type="button" value="등록" onclick="location.href='../bus/shuttle_bus_reg'">
				</div>
				<div id="busBox">
					<table id="busInfo" class="list">
						<tr>
							<th>구  분</th>
							<th>차량 번호</th>
							<th>담당 기사</th>
							<th>연락처</th>
							<th></th>
						</tr>
						<c:forEach items="${busList}" var="list">
							<tr class="bgc" onclick="route_view(${list.shuttle_num},'${list.shuttle_name}')" style="cursor:pointer;">
								<td>${list.shuttle_name}</td>
								<td>${list.shuttle_carnum}</td>
								<td>${list.staff_name}</td>
								<td>${list.staff_tel}</td>
								<td><a href="./modify_route?shuttle_num=${list.shuttle_num}">수정</a></td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<h2 id="routeTitle"></h2>
				<table id="routeInfo" style="display: none;">
				</table>

 			</div>
		</section>
</article>
<%@include file="../include/footer.jsp" %>
</body>
</html>