<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>행사 및 일정 등록</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css?">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
var currentDate  = new Date().toISOString().substring(0, 10);
$("#event_date").val(currentDate);


	$(function(){
		$("#register").click(function(){
			var event_name = $("#event_name").val();
			var event_date = $("#event_date").val();
			
			if (event_name == "") {
				alert("행사 명을 입력하세요.");
				return;
			};
			if (event_name.length > 20) {
				alert("행사 명은 20자 이하여야 합니다.");
				return;
			};
			if (event_date == "") {
				alert("행사 날짜를 입력하세요.");
				return;
			};
			
			$("form").submit();
			
			
		});
	})
</script>
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>

	<article>
			<div id="title_bar">
				<p>행사 및 일정</p>
				<h3>행사 및 일정 등록</h3>
			</div>
	
			
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<div id="register_form">
						 <form action="./event_register" method="POST">
						 	<table border="1">
						 		<tr>
						 			<th>행사 명</th>
						 		</tr>
						 		<tr>
						 			<td>
						 				<input type="hidden" name="staff_id" id="staff_id" value="${staff_id}">
						 				<input type="text" name="event_name" id="event_name">
						 			</td>
						 		</tr>
						 		<tr>
						 			<th>날짜</th>
						 		</tr>
						 		<tr>
						 			<td>
						 				<input type="date" name="event_date" id="event_date">
						 			</td>
						 		</tr>
						 		<tr>
						 			<td>
						 				<input type="button" id="register" value="등록">
						 			</td>
						 		</tr>
						 	</table>
						 </form>
					</div>
				</div>
			</section>
	</article>	

<%@include file="../include/footer.jsp" %>
</body>
</html>