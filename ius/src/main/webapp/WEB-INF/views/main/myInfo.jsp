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


$(function(){
	$("#staff_picFile").change(function(){
		if(this.files && this.files[0]) {
			var reader = new FileReader;
			reader.onload = function(data) {
				$(".select_img img").attr("src", data.target.result).width(94.4);
			}
			reader.readAsDataURL(this.files[0]);
		}	
	});

	
	$("#updateForm").click(function(){ // 수정 모드
		alert("수정할 항목을 입력한 후 완료 버튼을 누르세요.");
		
		// 변경 불가한 항목
		$("#staff_num").prop("disabled", true);
		$("#job_Kname").prop("disabled", true);
		$("#staff_id").prop("disabled", true);
		$("#staff_rrn1").prop("disabled", true);
		$("#staff_rrn2").prop("disabled", true);
		$("#staff_hireD").prop("disabled", true);
		$("#staff_workYn").prop("disabled", true);
		$("#staff_salary").prop("disabled", true);
		$("#staff_email").prop("disabled", true);
		
		// 변경 가능한 항목
		$("#staff_name").prop("readonly", false);
		$("#staff_addr").prop("readonly", false);
		$("#staff_zipcode").prop("readonly", false);
		$("#staff_tel").prop("readonly", false);
		
		// 사진업로드 항목 보이기
		$("#staff_picFile").show();
		
		$("#updateForm").hide();
		$("#cancel").show();
		$("#update").show();
			
	});
	
	$("#cancel").click(function(){ // 수정 취소
		alert("수정이 취소되었습니다.");
		
		var origin_addr = $("#origin_addr").val();
		var origin_zipcode = $("#origin_zipcode").val();
		var origin_tel = $("#origin_tel").val();
	
		$("#staff_addr").val(origin_addr);
		$("#staff_zipcode").val(origin_zipcode);
		$("#staff_tel").val(origin_tel);

		
		$("#staff_num").prop("disabled", false);
		$("#job_Kname").prop("disabled", false);
		$("#staff_id").prop("disabled", false);
		$("#staff_rrn1").prop("disabled", false);
		$("#staff_rrn2").prop("disabled", false);
		$("#staff_hireD").prop("disabled", false);
		$("#staff_workYn").prop("disabled", false);
		$("#staff_salary").prop("disabled", false);
		$("#staff_email").prop("disabled", false);
		
		$("#staff_name").prop("readonly", true);
		$("#staff_addr").prop("readonly", true);
		$("#staff_zipcode").prop("readonly", true);
		$("#staff_tel").prop("readonly", true);
		
		$("#staff_picFile").hide();
		
		$("#updateForm").show();
		$("#cancel").hide();
		$("#update").hide();
	});
	
	$("#update").click(function(){ // 수정
		alert("수정이 완료되었습니다.");
		
		$("#staff_num").prop("disabled", false);
		$("#job_Kname").prop("disabled", false);
		$("#staff_id").prop("disabled", false);
		$("#staff_rrn1").prop("disabled", false);
		$("#staff_rrn2").prop("disabled", false);
		$("#staff_hireD").prop("disabled", false);
		$("#staff_workYn").prop("disabled", false);
		$("#staff_salary").prop("disabled", false);
		$("#staff_email").prop("disabled", false);
		
		$("#staff_name").prop("readonly", true);
		$("#staff_addr").prop("readonly", true);
		$("#staff_zipcode").prop("readonly", true);
		$("#staff_tel").prop("readonly", true);
		
		$("#staff_picFile").hide();
		
		$("#updateForm").show();
		$("#cancel").hide();
		$("#update").hide();
		
		$("form").submit();
		
	});
});

</script>
<title>회원 정보</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>
	<article>
			<div id="title_bar">
				<p>회원 정보</p>
				<h3>회원 정보 </h3>
			</div>
	
			
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<div id="controllBtns">
						<input type="button" value="비밀번호 변경" onclick="location.href='../main/update_password_form'">
					</div>
					<div id="myInfo">
						<form name="frm" method="post" action="./update_staff_info" enctype="multipart/form-data">
							<table id="myInfoTbl" border="1">
								<tr>
									<th colspan="2">사번</th>
									<td colspan="2">
										<input type="text" id="staff_num" name="staff_num" readonly="readonly" value="${staff.staff_num}">
									</td>
								</tr>		
								<tr>
									<td rowspan="5" id="staff_picture" width='94.4px' height='113.3px'>
										<div class="select_img">
											<img src="${staff.staff_picture}" width='94.4px' height='113.3px'>
										</div>
										<input type="file" id="staff_picFile" name="staff_picFile" style="display : none;">
									</td>
								</tr>
								<tr>
									<th>이름</th>
									<td colspan="2">
										<input type="text" name="staff_name" id="staff_name" readonly="readonly" value="${staff.staff_name}">
									</td>
								</tr>
								<tr>
									<th>직무</th>
									<td colspan="2">
										<input type="hidden" id="staff_cls" name="staff_cls" value="${staff.staff_cls}">
										<input type="text" id="job_Kname" name="job_Kname" readonly="readonly" value="${staff.job_Kname}">
									</td>	
								</tr>
								<tr>
									<th>아이디</th>
									<td colspan="2">
										<input type="text" name="staff_id" id="staff_id" readonly="readonly" value="${staff.staff_id}">
									</td>
								</tr>
								<tr>
									<th colspan="2">주민등록번호</th>
									<td colspan="2">
										<input type="text" name="staff_rrn1" id="staff_rrn1" readonly="readonly" value="${staff.staff_rrn1}">
										-
										<input type="text" name="staff_rrn2" id="staff_rrn2" readonly="readonly" value="${staff.staff_rrn2}">
									</td>
								</tr>
								<tr>
									<th colspan="2">주소</th>
									<td colspan="2">
										<input type="text" name="staff_addr" id="staff_addr" readonly="readonly" value="${staff.staff_addr}">
										<input type="hidden" name="origin_addr" id="origin_addr" value="${staff.staff_addr}">	
									</td>
								</tr>
								<tr>
									<th>우편번호</th>
									<td>
										<input type="text" name="staff_zipcode" id="staff_zipcode" readonly="readonly" value="${staff.staff_zipcode}">
										<input type="hidden" name="origin_zipcode" id="origin_zipcode" value="${staff.staff_zipcode}">
									</td>
									<th>연락처</th>
									<td>
										<input type="tel" name="staff_tel" id="staff_tel" readonly="readonly" value="${staff.staff_tel}">
										<input type="hidden" name="origin_tel" id="origin_tel" value="${staff.staff_tel}">
									</td>
								</tr>
								<tr>
									<th colspan="2">입사일</th>
									<td colspan="2">
										<input type="date" name="staff_hireD" id="staff_hireD" readonly="readonly" value="${staff.staff_hireD}">
									</td>
								</tr>
								<tr>
									<th>재직여부</th>
									<td>
										<c:if test="${staff.staff_workYn == 'Y'}">
											<input type="text" name="staff_workYn" id="staff_workYn" value="재직" readonly="readonly">
										</c:if>
										<c:if test="${staff.staff_workYn == 'P'}">
											<input type="text" name="staff_workYn" id="staff_workYn" value="휴직" readonly="readonly">
										</c:if>		
										<c:if test="${staff.staff_workYn == 'N'}">
											<input type="text" name="staff_workYn" id="staff_workYn" value="퇴직" readonly="readonly">
										</c:if>
									</td>
									<th>월급</th>
									<td>
										<input type="text" id="staff_salary" readonly="readonly" value="<fmt:formatNumber maxFractionDigits="3" value="${staff.staff_salary}"/>">
									</td>
								</tr>
								<tr>
									<th colspan="2">이메일</th>
									<td colspan="2">
										<input type="email" name="staff_email" id="staff_email" readonly="readonly" value="${staff.staff_email}">
									</td>
								</tr>
								<tr>
									<td colspan="4">
										<input type="button" value="정보 수정" id="updateForm">
										<input type="button" value="취소" id="cancel" style="display : none;">
										<input type="button" value="수정 완료" id="update" style="display : none;">
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