<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="${path}/resources/js/class/classList.js"></script>
<title>학급 관리</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
<link type="text/css" rel="stylesheet" href="${path}/resources/css/class/classList.css">
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>
	<article>
			<div id="title_bar">
				<p>경영 정보</p>
				<h3>학급 관리</h3>
			</div>
	
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<div id="controllBtns">
						<input type="button" value="교직원 관리" onclick="location.href='../staff/staff_list'">
						<input type="button" value="학급 등록" onclick="location.href='../class/class_register_form'">
					</div>
						
						<div id="classBox" style="float : left;">
							<table id="classList" class="list" border="1"></table>
						</div>
						
						<div id="classInfo" style="float : left; display : none;">
							<table border="1" id="classInfoTbl">
								<tr>
									<th colspan="1">학급 번호</th>
									<td colspan="3">
										<input type="text" id="class_number" name="class_number" disabled="disabled">
									</td>
								</tr>
								<tr>
									<th colspan="1">학급 명</th>
									<td colspan="3">
										<input type="text" id="class_name" name="class_name" disabled="disabled">
									</td>	 
								</tr>
								<tr>
									<th>담당 교사</th>
									<td>
										<input type="text" id="staff_name" name="staff_name" disabled="disabled">
										<input type="hidden" id="staff_num" name="staff_num">
										<div id="homeTeacherSelect">
										</div>
									</td>
									<th>연락처</th>
									<td>
										<input type="text" id="staff_tel" name="staff_tel" disabled="disabled">
									</td>
								</tr>
								<tr>
									<td colspan="4" id="btnsTd">
										<input type="button" value="학급 정보 수정" id="updateForm">
										<input type="button" value="정보 수정 등록" id="update" style="display : none">
										<input type="button" value="취소" id="cancel" style="display : none">
										<input type="button" value="학급 정보 삭제" id="delete">
									</td>
								</tr>
							</table>
							<table id="classKinder" border="1" class="list">
							</table>
						</div>
								
				</div>
			</section>
	</article> 

<%@include file="../include/footer.jsp" %>	
</body>
</html>