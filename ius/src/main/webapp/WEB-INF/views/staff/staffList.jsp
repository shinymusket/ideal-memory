<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
function addComma(value){
	result = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); 
    return result;
};


function view(staff_num) {
	var staff_num = staff_num;
		
		$.ajax({
			url : "/ius/staff/get_staff_by_staff_num",
			type : "POST",
			data : {
				staff_num : staff_num
			},
			success : function(data) {
				
				$("#staff_num").val(data.staff.staff_num);
				$("#job_Kname").val(data.staff.job_Kname);
				$("#class_name").val(data.staff.class_name);
				$("#staff_id").val(data.staff.staff_id);
				$("#staff_age").val(data.staff.staff_age);
				
				var staff_sex = "";
				if (data.staff.staff_sex == 'M') {
					staff_sex = "남성";
				} else if (data.staff.staff_sex == 'F') {
					staff_sex = "여성";
				}
				$("#staff_sex").val(staff_sex);
				$("#staff_birth").val(data.staff.staff_birth);
				$("#staff_name").val(data.staff.staff_name);
				
				if ((data.staff.staff_picture == null)|| (data.staff.staff_picture == "")) {
					data.staff.staff_picture = "\\imgUpload\\no_image.jpg";
				}
				
				$("#staff_picture").html("<img src='" + data.staff.staff_picture + "' width='94.4px' height='113.3px'>");
				$("#staff_rrn1").val(data.staff.staff_rrn1);
				$("#staff_rrn2").val(data.staff.staff_rrn2);
				$("#staff_addr").val(data.staff.staff_addr);
				$("#staff_zipcode").val(data.staff.staff_zipcode);
				$("#staff_tel").val(data.staff.staff_tel);
				$("#staff_hireD").val(data.staff.staff_hireD);
				$("#staff_retireD").val(data.staff.staff_retireD);
				$("#staff_workYn").val(data.staff.staff_workYn);
				$("#staff_salary").val(addComma(data.staff.staff_salary));
				$("#staff_email").val(data.staff.staff_email);
				
				$("#staffInfo").show();
			}
		})
};




function getList() {
	$.ajax({
		url : "/ius/staff/get_staff_list",
		type : "POST",
		data : {
			
		},
		success: function(data) {
			$("#staffList").text("");			

			values = data.staffList;
			output = "<tr><th>구분</th><th>이름</th><th>연락처</th></tr>";			
			$.each(values, function(index, value) {
				
				output += "<tr>";
				output += "<td>" + value.job_Kname + "</td>";
				output += "<td><a href=\"javascript:view('" + value.staff_num + "');\">" + value.staff_name + "</a></td>";
				output += "<td>" + value.staff_tel + "</td>";
				output += "</tr>";
			});
			
			$("#staffList").html(output);
		}
		
	})
	
}
getList();

	$(function(){
		$("#search").click(function(){
			var staff_name = $("#search_staff_name").val();
			var staff_workYn = $("#search_staff_workYn").val();
			var staff_cls = $("#search_staff_cls").val();
			
			$.ajax({
				url : "/ius/staff/search_staff_list",
				type : "POST",
				data : {
					staff_name : staff_name,
					staff_workYn : staff_workYn,
					staff_cls : staff_cls
				},
				success: function(data) {
					$("#staffList").text("");			

					values = data.staffList;
					output = "<tr><th>구분</th><th>이름</th><th>연락처</th></tr>";			
					$.each(values, function(index, value) {
						
						output += "<tr>";
						output += "<td>" + value.job_Kname + "</td>";
						output += "<td><a href=\"javascript:view(" + value.staff_num + ");\">" + value.staff_name + "</a></td>";
						output += "<td>" + value.staff_tel + "</td>";
						output += "</tr>";
					});
					
					$("#staffInfo").hide();
					$("#staffList").html(output);
				}
				
			})
		});
		
		$("#update").click(function(){
			$("#staffInfo").hide();
			var staff_num = $("#staff_num").val();
			location.href="./staff_update_form?staff_num=" + staff_num;
		});
		
		$("#delete").click(function(){
			var staff_num = $("#staff_num").val();
			var input = confirm('정말 삭제하시겠습니까?');
			if (input === true) {
				$("#staffInfo").hide();
				alert("삭제되었습니다.");
				location.href="./staff_delete?staff_num=" + staff_num;
			} else {
				alert("취소되었습니다.");
			};
			
			
		});

})

</script>

<title>교직원 관리</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>
<article>
	<!-- 왼쪽 소제목 박스 (타이틀 써 주시면 됩니다) -->
		<div id="title_bar">
			<p>경영 정보</p>
			<h3>교직원 관리</h3>
		</div>

		<!-- 오른쪽 기능 박스 (검색 등등 필요없으면 div 안에 내용 지워도 무방)-->
		<div id="title_top">
		</div>

		<section>
			<div id="content">
				<div id="searchBar">
					<input type="button" value="교직원 등록" onclick="location.href='../staff/staff_register'">
					<input type="button" value="권한 관리" onclick="location.href='../authority/authority_edit'">
					<input type="button" value="근태 관리" onclick="location.href='../staff_attendance/attendance_list'">
					<input type="button" value="학급 관리" onclick="location.href='../class/class_list'">
					<br>
					이름<input type="text" id="search_staff_name" name="search_staff_name">
					상태
					<select id="search_staff_workYn" name="search_staff_workYn">
						<option value="Y" selected="selected">재직</option>
						<option value="P">휴직</option>
						<option value="N">퇴사</option>
					</select>
					직무
					<select id="search_staff_cls" name="search_staff_cls">
						<option value="" selected="selected">전체</option>
						<c:if test="${jobList != null}">
							<c:forEach items="${jobList}" var="job">
								<option value="${job.staff_cls}">${job.job_Kname}</option>
							</c:forEach>
						</c:if>
					</select>
					<input type="button" id="search" value="검색">
				</div>
				
			
			<table id="staffList" border="1" style="float : left;"></table>
	
	
			<table id="staffInfo" border="1" style="float : left; display : none;">
				<tr>
					<th colspan="2">교직원 코드</th>
					<td colspan="2">
						<input type="text" id="staff_num" readonly="readonly">
					</td>
				</tr>		
				<tr>
					<td rowspan="5" id="staff_picture" width='94.4px' height='113.3px'>
						<input type="file" name="staff_picFile" id="staff_picFile" style="display : none;">
						<div class="select_img">
							<img src="">
						</div>
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td colspan="2">
						<input type="text" id="staff_name" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>구분</th>
					<td colspan="2">
						<input type="text" id="job_Kname" readonly="readonly">
					</td>	
				</tr>
				<tr>
					<th>담당 반</th>
					<td colspan="2">
						<input type="text" id="class_name" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>아이디</th>
					<td colspan="2">
						<input type="text" id="staff_id" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>나이</th>
					<td>
						<input type="text" id="staff_age" readonly="readonly">
					</td>
					<th>성별</th>
					<td>
						<input type="text" id="staff_sex" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th colspan="2">생년월일</th>
					<td colspan="2">
						<input type="text" id="staff_birth" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th colspan="2">주민등록번호</th>
					<td colspan="2">
						<input type="text" id="staff_rrn1" readonly="readonly">-<input type="text" id="staff_rrn2" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th colspan="2">주소</th>
					<td colspan="2">
						<input type="text" id="staff_addr" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>우편번호</th>
					<td>
						<input type="text" id="staff_zipcode" readonly="readonly">
					</td>
					<th>연락처</th>
					<td>
						<input type="text" id="staff_tel" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>입사일</th>
					<td>
						<input type="date" id="staff_hireD" readonly="readonly">
					</td>
					<th>퇴사일</th>
					<td>
						<input type="date" id="staff_retireD" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>재직여부</th>
					<td>
						<input type="text" id="staff_workYn" readonly="readonly">
					</td>
					<th>월급</th>
					<td>
						<input type="text" id="staff_salary" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th colspan="2">이메일</th>
					<td colspan="2">
						<input type="text" id="staff_email" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<input type="button" value="정보 수정" id="update">
						<input type="button" value="삭제" id="delete">
					</td>
				</tr>
			</table>
		</div>
	</section>
</article> 

<%@include file="../include/footer.jsp" %>
</body>
</html>