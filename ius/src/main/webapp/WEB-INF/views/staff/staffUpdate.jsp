<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
$(function(){
		//키를 누르거나 떼었을때 이벤트 발생
	    $("#staff_salary").bind('keyup keydown',function(){
	        inputNumberFormat(this);
	    });
	
	    //입력한 문자열 전달
	    function inputNumberFormat(obj) {
	        obj.value = comma(uncomma(obj.value));
	    };
	      
	    //콤마찍기
	    function comma(str) {
	        str = String(str);
	        return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	    };
	
	    //콤마풀기
	    function uncomma(str) {
	        str = String(str);
	        return str.replace(/[^\d]+/g, '');
	    };
	
	    //숫자만 리턴(저장할때)
	    //alert(cf_getNumberOnly('1,2./3g')); -> 123 return
	    function cf_getNumberOnly (str) {
	        var len      = str.length;
	        var sReturn  = "";
	
	        for (var i=0; i<len; i++){
	            if ( (str.charAt(i) >= "0") && (str.charAt(i) <= "9") ){
	                sReturn += str.charAt(i);
	            }
	        }
	        return sReturn;
	    };

	    $("#update").click(function(){
	    	var email = $("#staff_email").val();
	    	var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
	    	
	   
		if ($("#staff_cls").val() == "") {
			alert("직무를 선택해주세요.");
			$("#staff_cls").val().focus();
			return;
		};
		
		
		if ($("#staff_name").val() == "") {
			alert("이름을 입력해주세요.");
			$("#staff_name").val().focus();
			return;
		};
		
		if ($("#staff_rrn1").val() == "" || $("#staff_rrn2").val() == "") {
			alert("주민등록번호를 입력해주세요.");
			$("#staff_rrn").val().focus();
			return;
		};
		
		if ($("#staff_rrn1").val().length != 6) {
			alert("주민등록번호 앞자리 입력이 잘못되었습니다.");
			$("#staff_rrn1").val().focus();
			return;
		};
		
		if ($("#staff_rrn2").val().length != 7) {
			alert("주민등록번호 뒷자리 입력이 잘못되었습니다.");
			$("#staff_rrn2").val().focus();
			return;
		};
		
		if (email == "") {
			alert("이메일은 필수 입력 항목입니다.");
			$("#staff_email").val().focus();
			return;
		} else if (exptext.test(email) == false) {
			alert("이메일 형식이 올바르지 않습니다.");
			$("#staff_email").val().focus();
			return;
		};
			
			
		value = cf_getNumberOnly ($("#staff_salary").val());
			
			$("#staff_salary").val(value);
			$("form").submit();
			
		});
		

})
</script>
<title>교직원 정보 수정</title>
</head>
<body>
	<h1>교직원 정보 수정</h1>
	<input type="button" value="목록으로" onclick="location.href='./staff_list'">
	<form action="./staff_update" method="POST">
		<table border="1">
			<tr>
				<th>교직원 코드</th>
				<td>
					<input type="text" name="staff_num" id="staff_num" value="${staff.staff_num}" readonly="readonly">
				</td>
				<th>구분</th>
				<td>
					<select name="staff_cls" id="staff_cls">
						<c:forEach items="${jobList}" var="job" >
							<c:if test="${staff.staff_cls == job.staff_cls}">
								<option value="${job.staff_cls}" selected="selected">${job.job_Kname}</option>					
							</c:if>
							<c:if test="${staff.staff_cls != job.staff_cls}">
								<option value="${job.staff_cls}">${job.job_Kname}</option>
							</c:if>
						</c:forEach>
					</select>
					
				</td>
			</tr>
			<tr>
				<th>아이디</th>
				<td>
					<input type="text" name="staff_id" id="staff_id" value="${staff.staff_id}" readonly="readonly">
				</td>
				<th>이름</th>
				<td>
					<input type="text" name="staff_name" id="staff_name" value="${staff.staff_name}"> 
				</td>
			</tr>
			<tr>
				<th>주민등록번호</th>
				<td>
					<input type="text" name="staff_rrn1" id="staff_rrn1" value="${staff.staff_rrn1}">
					-
					<input type="text" name="staff_rrn2" id="staff_rrn2" value="${staff.staff_rrn2}">
				</td>
				<th>주소</th>
				<td>
					<input type="text" name="staff_addr" id="staff_addr" value="${staff.staff_addr}">
				</td>
			</tr>
			<tr>
				<th>우편번호</th>
				<td>
					<input type="text" name="staff_zipcode" id="staff_zipcode" value="${staff.staff_zipcode}">
				</td>
				<th>연락처</th>
				<td>
					<input type="tel" name="staff_tel" id="staff_tel" value="${staff.staff_tel}">
				</td>
			</tr>
			<tr>
				<th>입사일</th>
				<td>
					<input type="date" name="staff_hireD" id="staff_hireD" value="${staff.staff_hireD}">
				</td>
				<th>퇴사일</th>
				<td>
					<input type="date" name="staff_retireD" id="staff_retireD" value="${staff.staff_retireD}">
				</td>
			</tr>
			<tr>
				<th>재직여부</th>
				<td>
					<c:if test="${staff.staff_workYn == 'Y'}">
						<select name="staff_workYn" id="staff_workYn">
							<option value="Y" selected="selected">재직</option>
							<option value="P">휴직</option>
							<option value="N">퇴사</option>
						</select>
					</c:if>
					
					<c:if test="${staff.staff_workYn == 'P'}">
						<select name="staff_workYn" id="staff_workYn">
							<option value="Y">재직</option>
							<option value="P" selected="selected">휴직</option>
							<option value="N" >퇴사</option>
						</select>
					</c:if>		
					
					<c:if test="${staff.staff_workYn == 'N'}">
						<select name="staff_workYn" id="staff_workYn">
							<option value="Y">재직</option>
							<option value="P">휴직</option>
							<option value="N" selected="selected">퇴사</option>
						</select>
					</c:if>
	
				</td>
				<th>월급</th>
				<td>
					<input type="text" name="staff_salary" id="staff_salary" value="${staff.staff_salary}" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"> 
				</td>
			</tr>
			<tr>
				<th colspan="2">이메일</th>
				<td colspan="2">
					<input type="email" name="staff_email" id="staff_email" value="${staff.staff_email}">
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<input type="button" value="수정" id="update">
					<input type="reset" value="취소">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>