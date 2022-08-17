<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>근태 관리</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
<link type="text/css" rel="stylesheet" href="${path}/resources/css/staff_attendance/attendanceList.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="${path}/resources/js/staff_attendance/attendanceList.js"></script>
</head>
<body>
	<%@include file="../include/header.jsp" %>
	<%@include file="../include/nav.jsp" %>

	<article>
		<!-- 왼쪽 소제목 박스 (타이틀 써 주시면 됩니다) -->
			<div id="title_bar">
				<p>경영 정보</p>
				<h3>근태 관리</h3>
			</div>
	
			<!-- 오른쪽 기능 박스 (검색 등등 필요없으면 div 안에 내용 지워도 무방)-->
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<div id="controllBtns">
						<input type="button" value="교직원 관리" onclick="location.href='../staff/staff_list'">
					</div>
					
					<div id="searchDiv">
						<input type="text" id="staff_name" name="staff_name" readonly="readonly">
						<input type="hidden" id="staff_id">
						<input type="date" id="date_from">
						<input type="date" id="date_to">
						<input type="button" id="search" value="조회">
					</div>
					
					<div id="staffBox"  style="float: left;">
						<c:if test="${staffList != null}">
							<table border="1" class="list" id="staff_list">
								<tr>
									<th>사번</th>
									<th>교직원 이름</th>
									<th>직무</th>
								</tr>
								<c:forEach items="${staffList}" var="staff">
									<tr>
										<td>${staff.staff_num}</td>
										<td><a href="javascript:getInfo('${staff.staff_id}', '${staff.staff_name}');">${staff.staff_name}</a></td>
										<td>${staff.job_Kname}</td>
									</tr>
								</c:forEach>
							</table>
						</c:if>
					</div>
					
					<table id="attendanceInfo" class="tbl paginated" style="float: left; display: none;" border="1">
					</table>
				
				</div>
			</section>
	</article> 

		
		
		
		
	<%@include file="../include/footer.jsp" %>
</body>
</html>