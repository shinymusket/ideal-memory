<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>권한 관리</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
 function getInfo(num) {
	 var staff_num = num;
	 
	 var objParams = {
				staff_num : staff_num
		}
	 
	 $.post(
				"/ius/authority/get_authority_info",
				objParams,
				function(retVal) {
					$("#authorityInfo").hide();
					
					$("#master").prop('checked', false);
					$("#teacher").prop('checked', false);
					$("#dietitian").prop('checked', false);
					$("#facilities").prop('checked', false);
					$("#bus").prop('checked', false);
					$("#info").prop('checked', false);
					$("#event").prop('checked', false);
					$("#gallery").prop('checked', false);
					$("#staff_num").val(staff_num);
					
					value = retVal.authorityInfo;		
					
					
					
					if (value.m == "Y") {
						$("#master").prop('checked', true);
						$("#teacher").prop('disabled', true);
						$("#dietitian").prop('disabled', true);
						$("#facilities").prop('disabled', true);
						$("#bus").prop('disabled', true);
						$("#info").prop('disabled', true);
						$("#event").prop('disabled', true);
						$("#gallery").prop('disabled', true);
						
						
					};
					if (value.t == "Y") {
						$("#teacher").prop('checked', true);
					};
					if (value.d == "Y") {
						$("#dietitian").prop('checked', true);
					};
					if (value.f == "Y") {
						$("#facilities").prop('checked', true);
					};
					if (value.s == "Y") {
						$("#bus").prop('checked', true);
					};
					if (value.i == "Y") {
						$("#info").prop('checked', true);
					};
					if (value.e == "Y") {
						$("#event").prop('checked', true);
					};
					if (value.g == "Y") {
						$("#gallery").prop('checked', true);
					};
					
					$("#authorityInfo").show();
					
				}
					)
 }



$(function(){
		$("#master").change(function() { // 마스터 권한 체크시 모든 항목 자동 선택, 
		    if(this.checked) {
		       $("#teacher").prop('checked', true);
		       $("#teacher").prop('disabled', true);
		       $("#dietitian").prop('checked', true);
		       $("#dietitian").prop('disabled', true);
		       $("#facilities").prop('checked', true);
		       $("#facilities").prop('disabled', true);
		       $("#bus").prop('checked', true);
		       $("#bus").prop('disabled', true);
		       $("#info").prop('checked', true);
		       $("#info").prop('disabled', true);
		       $("#event").prop('checked', true);
		       $("#event").prop('disabled', true);
		       $("#gallery").prop('checked', true);
		       $("#gallery").prop('disabled', true);
		    };
		    
		    if(!this.checked) {
		    	$("#teacher").prop('checked', false);
		    	$("#teacher").prop('disabled', false);
			    $("#dietitian").prop('checked', false);
			    $("#dietitian").prop('disabled', false);
			    $("#facilities").prop('checked', false);
			    $("#facilities").prop('disabled', false);
			    $("#bus").prop('checked', false);
			    $("#bus").prop('disabled', false);
			    $("#info").prop('checked', false);
			    $("#info").prop('disabled', false);
			    $("#event").prop('checked', false);
			    $("#event").prop('disabled', false);
			    $("#gallery").prop('checked', false);
			    $("#gallery").prop('disabled', false);
		    }
		});
		
		$("#register").click(function() {
			var master;
			var teacher;
			var dietitian;
			var facilities;
			var bus;
			var info;
			var event;
			var gallery;

			if ($("#master").is(':checked')) {
				master = "Y";
			} else if(!$("#master").is(':checked')) {
				master = "N";
			};
			if ($("#teacher").is(':checked')) {
				teacher = "Y";
			} else if(!$("#teacher").is(':checked')) {
				teacher = "N";
			};
			if ($("#dietitian").is(':checked')) {
				dietitian = "Y";
			} else if(!$("#dietitian").is(':checked')) {
				dietitian = "N";
			};
			if ($("#facilities").is(':checked')) {
				facilities = "Y";
			} else if(!$("#facilities").is(':checked')) {
				facilities = "N";
			};
			if ($("#bus").is(':checked')) {
				bus = "Y";
			} else if(!$("#bus").is(':checked')) {
				bus = "N";
			};
			if ($("#info").is(':checked')) {
				info = "Y";
			} else if(!$("#info").is(':checked')) {
				info = "N";
			};
			if ($("#event").is(':checked')) {
				event = "Y";
			} else if(!$("#event").is(':checked')) {
				event = "N";
			};
			if ($("#gallery").is(':checked')) {
				gallery = "Y";
			} else if(!$("#gallery").is(':checked')) {
				gallery = "N";
			};
			
			var objParams = {
				master : master,
				teacher : teacher,
				dietitian : dietitian,
				facilities : facilities,
				bus : bus,
				info : info,
				event : event,
				gallery : gallery,
				staff_num : $("#staff_num").val()
			}
			
			$.post(
					"/ius/authority/set_authority_info",
					objParams,
					function(retVal) {
						alert("권한이 등록 되었습니다.");
					}
					
				)
		});
	
}) 


	



</script>
</head>
<body>
	<h1>권한 부여</h1>
	<div id="btns">
		<input type="button" value="홈으로" onclick="location.href='../main/'">
		<input type="button" value="교직원 관리" onclick="location.href='../staff/staff_list'">
	</div>
	
	<table id="staffInfo" border="1" style="float: left;">
		<tr>
			<th>교직원 코드</th>
			<th>교직원 이름</th>
			<th>교직원 아이디</th>
			<th>직무</th>
		</tr>
		<c:if test="${staffList != null}">
			<c:forEach items="${staffList}" var="staff">
				<tr>
					<td>${staff.staff_num}</td>
					<td>${staff.staff_name}</td>
					<td><a href="javascript:getInfo(${staff.staff_num})">${staff.staff_id}</a></td>
					<td>${staff.job_Kname}</td>
				</tr>
			</c:forEach>
		</c:if>	
	</table>
	
	<table id="authorityInfo" border="1" style="float: left; display: none;">
		<tr>
			<th>권한</th>
			<td>여부</td>
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
			<td colspan="2">
				<input type="hidden" id="staff_num">
				<input type="button" id="register" value="등록">
			</td>
		</tr>
		
	</table>
</body>
</html>