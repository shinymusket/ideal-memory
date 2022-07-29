<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>근태 관리</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	function getInfo(id, name) {
		var staff_id = id;
		var staff_name = name;
		
		var objParams = {
				id : staff_id
		}
		
		var values = [];
		
		$.post(
			"/ius/staff_attendance/getInfo",
			objParams,
			function(retVal) {
				$("#attendanceInfo").text("");
				$("#staff_name").text("");
				
				values = retVal.attendInfo;
				
				output = "<tr><th>일시</th><th>출결 정보</th><th>출근시간</th><th>퇴근시간</th></tr>";
				$.each(values, function(index, value) {
					
					attend_info = value.attend_info
					
					if (attend_info == "T") {
						attend_info = "출근";
					} else if (attend_info == "B") {
						attend_info = "결근";
					} else if (attend_info == "L") {
						attend_info = "지각";
					} else if (attend_info == "E") {
						attend_info = "조퇴";
					} else if (attend_info == "H") {
						attend_info = "휴가";
					};
					
					output += "<tr>";
					output += "<td>"+ value.attend_date +"</td>";
					output += "<td>"+ attend_info +"</td>";
					output += "<td>"+ value.in_time +"</td>";
					output += "<td>"+ value.out_time +"</td>";	
				});
				
				$("#attendanceInfo").show();
				$("#attendanceInfo").html(output);
				$("#staff_name").val(staff_name);
				$("#staff_id").val(staff_id);
				
				
			}
		)
	};
	
	$(function() {
		$("#search").click(function(){
			if ($("#date_from").val() == "") {
				alert("시작 일자를 설정해주세요.");
				return;
			};
			
			if ($("#date_to").val() == "") {
				alert("끝 일자를 설정해주세요.");
				return;
			};
			
			var staff_id = $("#staff_id").val();
			
			var objParams = {
					staff_id : staff_id,
					from : $("#date_from").val(),
					to : $("#date_to").val()
			}
			
			var values = [];
			
			$.post(
				"/ius/staff_attendance/getInfoByDate",
				objParams,
				function(retVal) {
					$("#attendanceInfo").text("");
					
					values = retVal.attendInfo;
					
					output = "<tr><th>일시</th><th>출결 정보</th><th>출근시간</th><th>퇴근시간</th></tr>";
					$.each(values, function(index, value) {
						
						attend_info = value.attend_info;
						
						if (attend_info == "T") {
							attend_info = "출근";
						} else if (attend_info == "B") {
							attend_info = "결근";
						} else if (attend_info == "L") {
							attend_info = "지각";
						} else if (attend_info == "E") {
							attend_info = "조퇴";
						} else if (attend_info == "H") {
							attend_info = "휴가";
						};
						
						output += "<tr>";
						output += "<td>"+ value.attend_date +"</td>";
						output += "<td>"+ attend_info +"</td>";
						output += "<td>"+ value.in_time +"</td>";
						output += "<td>"+ value.out_time +"</td>";	
					});
					
					$("#attendanceInfo").show();
					$("#attendanceInfo").html(output);
					$("#staff_id").val(staff_id);
					
					
				}
			)
		});
		
		
		
		
	})
	
	

	
	
		

	




	

</script>
</head>
<body>
	<h1>근태 관리</h1>
	<div class="btns">
		<input type="button" value="교직원 관리" onclick="location.href='../staff/staff_list'">
	</div>
	
	<h2>근태 기록 조회</h2>
	<div class="btns">
		<input type="text" id="staff_name" readonly="readonly">
		<input type="hidden" id="staff_id">
		<input type="date" id="date_from">
		<input type="date" id="date_to">
		<input type="button" id="search" value="조회">
	</div>
	<c:if test="${staffList != null}">
		<table style="float: left;" border="1">
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
	
	<table id="attendanceInfo" style="float: left; display: none;" border="1">
<!-- 		<tr>
			<th>일시</th>
			<th>출결정보</th>
			<th>출근시간</th>
			<th>퇴근시간</th>
		</tr> -->
	</table>
	
	
	
</body>
</html>