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
			$("#kinder_picFile").change(function(){
				if(this.files && this.files[0]) {
					var reader = new FileReader;
					reader.onload = function(data) {
						$(".select_img img").attr("src", data.target.result).width(500);
					}
					reader.readAsDataURL(this.files[0]);
				}	
			});
		
			var currentDate  = new Date().toISOString().substring(0, 10);
			$("#kinder_regdate").val(currentDate);
			
		    $("#register").click(function(){
		    	
			if ($("#shuttle_num").val() == "") {
				alert("셔틀버스를 선택해주세요.");
				return;
			};
			
			if ($("#staff_num").val() == "") {
				alert("담임교사를 선택해주세요.");
				return;
			};
			
			if ($("#kinder_name").val() == "") {
				alert("원생 이름을 입력해주세요.");
				$("#kinder_name").val().focus();
				return;
			};
			
			if ($("#kinder_rrn1").val() == "" || $("#kinder_rrn2").val() == "") {
				alert("주민등록번호를 입력해주세요.");
				$("#kinder_rrn1").val().focus();
				return;
			};
			
			if ($("#kinder_rrn1").val().length != 6) {
				alert("주민등록번호 앞자리 입력이 잘못되었습니다.");
				$("#kinder_rrn1").val().focus();
				return;
			};
			
			if ($("#kinder_rrn2").val().length != 7) {
				alert("주민등록번호 뒷자리 입력이 잘못되었습니다.");
				$("#kinder_rrn2").val().focus();
				return;
			};
			
			
			$("form").submit();
			
		});
		
		$("#staff_cls_edit").click(function(){
			url = "./job_class_Edit";
			window.open(url, "_blank_1", "toolbar=no, menubar=no, scrollbar=yes, resizeable=no, width=550, height=400");
		});
		
	})
	
</script>
<title>원생 등록</title>
</head>
<body>
	<h1>원생 등록</h1>
	<input type="button" value="원생 목록" onclick="location.href='../kinder/kinder_list'">
	<form action="./kinder_register" method="POST" name="frm" enctype="multipart/form-data">
		<table border="1">
			<tr>
				<th>원생 번호</th>
				<td>
					${nextKinderSeq}
				</td>
			</tr>
			<tr>
				<th>셔틀 버스 호차</th>
				<td>
					<select name="shuttle_num" id="shuttle_num">
						<option value="">-선택-</option>
						<c:if test="${shuttleList != null}">
							<c:forEach items="${shuttleList}" var="shuttle">
								<option value="${shuttle.shuttle_num}">${shuttle.shuttle_num}호차] ${shuttle.shuttle_carNum}</option>
							</c:forEach>
						</c:if>
					</select>
				</td>
			</tr>
			<tr>
				<th>담임 교사</th>
				<td>
					<select name="staff_num" id="staff_num">
						<option value="">-선택-</option>
						<c:if test="${homeTeacherList != null}">
							<c:forEach items="${homeTeacherList}" var="homeTeacher">
								<option value="${homeTeacher.staff_num}">${homeTeacher.staff_name}</option>
							</c:forEach>
						</c:if>
					</select>
				</td>
			</tr>
			<tr>
				<th>원생 이름</th>
				<td>
					<input type="text" name="kinder_name" id="kinder_name">
				</td>
				
			</tr>
			<tr>
				<th>주민등록번호</th>
				<td>
					<input type="text" name="kinder_rrn1" id="kinder_rrn1">-<input type="text" name="kinder_rrn2" id="kinder_rrn2">
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>
					<input type="text" name="kinder_addr" id="kinder_addr">
				</td>
			</tr>
			<tr>
				<th>우편번호</th>
				<td>
					<input type="text" name="kinder_zipcode" id="kinder_zipcode">
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>
					<input type="tel" name="kinder_tel" id="kinder_tel">
				</td>
			</tr>
			<tr>
				<th>등록 일</th>
				<td>
					<input type="date" name="kinder_regdate" id="kinder_regdate">
				</td>
			</tr>
			<tr>
				<th>퇴원 일</th>
				<td>
					<input type="date" name="kinder_retireDate" id="kinder_retireDate">
				</td>
			</tr>
			<tr>
				<th>재원 상태</th>
				<td>
					<select name="kinder_regYn" id="kinder_regYn">
						<option value="Y" selected="selected">재원</option>
						<option value="P">휴원</option>
						<option value="N">퇴원</option>
						<option value="G">졸업</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>프로필 사진</th>
				<td>
					<input type="file" name="kinder_picFile" id="kinder_picFile">
					<div class="select_img">
						<img src="">
					</div>
					<%=request.getRealPath("/")%>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" value="등록" id="register"> 
				</td>
			</tr>
		</table>
	</form>
</body>
</html>