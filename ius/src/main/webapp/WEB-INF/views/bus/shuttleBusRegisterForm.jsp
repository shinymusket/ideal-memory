<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<title>셔틀버스 등록</title>
<link rel="stylesheet" href="${path}/resources/css/articleF.css">
<link rel="stylesheet" href="${path}/resources/css/shuttle/shuttleBusRegisterForm.css">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<%-- <script type="text/javascript" src="${path}/resources/js/shuttle/shuttleBusRegisterForm.js"></script> --%>
<script type="text/javascript">

function d_Value(target) {
	  // 선택한 option의 value 값
	  const driverValue = target.value;
	  console.log(target.value);
	  
		$.ajax({
			url : "/ius/bus/get_driver_tel",
			type : "POST",
			data : {
				staff_num : driverValue
			},
			success: function(data){
				console.log(data.staff_tel);
				$("#driver_tel").val(data.staff_tel);
			}
		})
	};
	
	$(document).ready(function(){            
		   
        var wrapper = $("#bus_list");
        var add_button = $(".add_bus_button");

        $(add_button).click(function(e) {
            e.preventDefault();
                $(wrapper).append("<tr class='input_bus_list'>"
                        +"<td><select class='hour' name='shuttle_hour[]'>"
                        +"<c:forEach var='h' begin='0' end='24'><c:choose><c:when test='${h < 10 }'><option value='0${h}'>0${h}</option>"
					    +"</c:when><c:otherwise><option value='${h}'>${h}</option></c:otherwise></c:choose></c:forEach></select> 시"
                        +"<select class='minute' name='shuttle_minute[]'><c:forEach var='m' begin='0' end='59'><c:choose><c:when test='${m < 10}'><option value='0${m}'>0${m}</option>"
                        +"</c:when><c:otherwise><option value='${m}'>${m}</option></c:otherwise></c:choose></c:forEach></select> 분</td>"
                        +"<td><input type='text' name='bus_stop[]' required='required'></td>"
                        +"<td class='del_button'><input type='button' value='삭제'></td><tr>");
        });
        
        $(wrapper).on("click", ".del_button", function(e) {
            e.preventDefault();
            $(this).parent('.input_bus_list').remove();
        });   
             
});
</script>

</head>
<body>
<%@include file="../include/header.jsp"%>
<%@include file="../include/nav.jsp"%>

<article>
		<!-- 왼쪽 소제목 박스 -->
		<div id="title_bar">
			<p>경영 정보</p>
			<h3>셔틀버스 등록</h3>
		</div>

		<!-- 오른쪽 기능 박스 (검색)-->
		<div id="title_top">
			
		</div>

		<!-- 내용 구간 -->
		<!-- 내용 넣으면 길이 알아서 늘어나요(아마도) -->
		<section>
			<div id="content">
				<input type="button" value="목록으로" onclick="location.href='./shuttle_bus'">
				
				<form action="./input_bus_route" method="POST">
					<input type="hidden" name="shuttle_num" value="${nextShuttleSeq}">
					<table border="1" class="list">
						<tr>
							<th>구  분</th>
							<td><input type="text" name="shuttle_name"></td>
						</tr>
						<tr>
							<th>차량 번호</th>
							<td><input type="text" maxlength="10" name="shuttle_carnum"></td>
						</tr>
						<tr>
							<th>담당 기사</th>
							<td>
								<select name="staff_num" onchange="d_Value(this)">
									<option value="none" disabled selected>==선 택==</option>
									<c:forEach items="${driverList}" var="dL">
										<option value="${dL.staff_num}">${dL.staff_name}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th>연락처</th>
							<td>
								<input type="text" name="driver_tel" id="driver_tel" readonly>
							</td>
						</tr>
						</table>
						<table border="1" id="bus_list" class="list">
							<tr>
								<th colspan="2">노선<input name="addButton" class="add_bus_button" type="button" value="+"></th>
							</tr>
							<tr>
								<th>시간</th>
								<th>승하차장</th>
							</tr>
							<tr>
								<td>
									<select class="hour" name="shuttle_hour[]">
										<c:forEach var="h" begin="0" end="24">
										<c:choose>
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
								<td>
									<input type="text" name="bus_stop[]" required="required">
								</td>
								<td class='del_button'>
								</td>
							</tr>
						</table>
						<input type="submit" value="등록">
				</form>
			</div>
		</section>
	</article>
	<%@include file="../include/footer.jsp" %>
</body>
</html>