<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>행사 및 일정 보기</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
<link type="text/css" rel="stylesheet" href="${path}/resources/css/event/eventInfo.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="${path}/resources/js/event/eventInfo.js"></script>
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>

	<article>
			<div id="title_bar">
				<p>행사 및 일정</p>
				<h3>행사 및 일정 보기</h3>
			</div>
	
			
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<input type="button" value="목록으로 돌아가기" onclick="location.href='../event/event_list'">
					<table border="1" id="eventInfo">
						<thead>
							<tr>
								<th>날짜</th>
							</tr>
							<tr>
								<td>
									<input type="hidden" value="${staff_id}" id="staff_id"> <!-- 현재 로그인한 사람의 아이디 -->
									<input type="date" value="${event_date}" id="event_date">
								</td>
							</tr>
						</thead>
						<tbody></tbody>
							
						<tfoot>
							<tr>
								<td>
									<input type="hidden" id="event_num">
									<input type="text" id="event_name">
									<input type="hidden" id="register_staff_id"> <!-- 등록한 사람의 아이디  --> 
								</td>
							</tr>
							<tr>
								<td>
									<input type="button" value="추가" id="register">
									<input type="button" value="수정" id="update">
									<input type="button" value="삭제" id="delete">
									<input type="button" value="비우기" id="cancel">
								</td>
							</tr>
						</tfoot>
					</table>
				</div>
			</section>
	</article>	

<%@include file="../include/footer.jsp" %>
</body>
</html>