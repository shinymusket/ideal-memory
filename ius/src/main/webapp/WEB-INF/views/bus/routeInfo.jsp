<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<title>셔틀버스 정보 수정</title>
<link rel="stylesheet" href="${path}/resources/css/articleF.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="${path}/resources/js/shuttle/routeInfo.js"></script>
<link rel="stylesheet" href="${path}/resources/css/shuttle/shuttleBusRegisterForm.css">
</head>
<script>

$(document).ready(function() {
	
	var wrapper = $("#bus_route");
	var add_button = $(".add_bus_button");

	$(add_button).click(function(e) {
	    e.preventDefault();
	        $(wrapper).append("<tr class='input_route'>"
	                +"<td><input type='hidden' name='route_id[]' class='route_id'><select class='hour' name='shuttle_hour[]'>"
	                +"<c:forEach var='h' begin='0' end='24'><c:choose><c:when test='${h < 10 }'><option value='0${h}'>0${h}</option>"
	    			+"</c:when><c:otherwise><option value='${h}'>${h}</option></c:otherwise></c:choose></c:forEach></select> 시"
	                +"<select class='minute' name='shuttle_minute[]'><c:forEach var='m' begin='0' end='59'><c:choose><c:when test='${m < 10}'><option value='0${m}'>0${m}</option>"
	                +"</c:when><c:otherwise><option value='${m}'>${m}</option></c:otherwise></c:choose></c:forEach></select> 분</td>"
	                +"<td><input type='text' name='bus_stop[]' required='required'></td>"
	                +"<td class='del_button'>&times;</td><tr>");
		});

	  $("#bus_route").on("click", ".deleteInput", function(e) {
	        e.preventDefault();
	        
			var num = $(this).parent('.input_route').find('.route_id').val();
	        
	        $.ajax({
	        	url : "/ius/bus/route_delete",
	        	type : "POST",
	        	data : {
	        		route_id : num
	        	},
	        	success : function(data) {
	        		alert("삭제되었습니다.");
	        	}
	        })

	        $(this).parent('.input_route').remove();
	  });
	  
	  $("#bus_route").on("click", ".del_button", function(e){
		  e.preventDefault();
		  $(this).parent('.input_route').remove();
	  });
	  
});
</script>
<body>
<%@include file="../include/header.jsp"%>
<%@include file="../include/nav.jsp"%>
	<article>
		<!-- 왼쪽 소제목 박스 -->
		<div id="title_bar">
			<p>경영 정보</p>
			<h3>셔틀버스 수정</h3>
		</div>

		<!-- 오른쪽 기능 박스 (검색)-->
		<div id="title_top">		
		</div>

		<!-- 내용 구간 -->
		<!-- 내용 넣으면 길이 알아서 늘어나요(아마도) -->
		<section>
			<div id="content">
				<input type="button" value="목록으로" onclick="location.href='./shuttle_bus'">
				<form action="./modify_bus_route" method="POST">
				<input type="hidden" name="shuttle_num" value="${bus.shuttle_num}">
						<table border="1" id="busInfo">
							<tr>
								<th>구  분</th>
								<td><input type="text" name="shuttle_name" value="${bus.shuttle_name}"></td>
							</tr>
							<tr>
								<th>차량 번호</th>
								<td><input type="text" name="shuttle_carnum" value="${bus.shuttle_carnum}"></td>
							</tr>
							<tr>
								<th>담당 기사</th>
								<td>
								<select name="staff_num" onchange="d_Value(this)">
									<option value="none" disabled>==선 택==</option>
									<c:forEach items="${driverList}" var="dL">
										<c:choose>
										<c:when test="${dL.staff_num eq bus.staff_num}">
											<option value="${dL.staff_num}" selected>${dL.staff_name}</option>
										</c:when>
										<c:otherwise>
											<option value="${dL.staff_num}">${dL.staff_name}</option>
										</c:otherwise>
										</c:choose>
									</c:forEach>
								</select>
								</td>
							</tr>
							<tr>
								<th>연락처</th>
								<td>
									<input type="tel" value="${bus.staff_tel}" id="driver_tel">
								</td>
							</tr>
							</table>
					
					<h2>차량별 노선</h2>
						<table border="1" id="bus_route">
							<tr>
								<th colspan="2">노선<input name="addButton" class="add_bus_button" type="button" value="+"></th>
							</tr>
							<tr>
								<th>시간</th>
								<th>승하차장</th>
							</tr>
							<c:forEach items="${route}" var="route">
								<tr class='input_route'>
									<input type="hidden" name="route_id[]" class="route_id" value="${route.route_id}">
									<td>
									<select class="hour" name="shuttle_hour[]">
										<c:forEach var="h" begin="0" end="24">
										<c:choose>
											<c:when test="${h eq route.shuttle_hour}">
											<option value="${route.shuttle_hour}" selected>${route.shuttle_hour}</option>
											</c:when>
									      	<c:when test="${h < 10 }">
									          <option value="0${h}">0${h}</option>
									      	</c:when>
									      	<c:otherwise>
									          <option value="${h}">${h}</option>
									      	</c:otherwise>
										</c:choose>
										</c:forEach>
									</select>
									시
									<select class="minute" name="shuttle_minute[]">
										<c:forEach var="m" begin="0" end="59">
									  		<c:choose>
									  		<c:when test="${m eq route.shuttle_minute}">
												<option value="${route.shuttle_minute}" selected>${route.shuttle_minute}</option>
											</c:when>
										      <c:when test="${m < 10 }">
										          <option value="0${m}">0${m}</option>
										      </c:when>
										      <c:otherwise>
										          <option value="${m}">${m}</option>
										      </c:otherwise>
										  </c:choose>
										</c:forEach>
									</select>
									분
									</td>
									<td><input type="text" name="bus_stop[]" value="${route.bus_stop}"></td>
									<td class='deleteInput' title='Delete'>&times;</td>
								</tr>
							</c:forEach>
					</table>
					<input type="submit" value="등록">
					<input type="button" value="삭제" onclick="location.href='./delete_bus_info?shuttle_num=${bus.shuttle_num}'">
				</form>
			</div>
		</section>
	</article>
<%@include file="../include/footer.jsp" %>
</body>
</html>