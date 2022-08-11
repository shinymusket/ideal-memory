<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<title>원생 정보 수정</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>
	
	<article>
			<div id="title_bar">
				<p>원생 관리</p>
				<h3>원생 정보 수정</h3>
			</div>
	
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<input type="button" value="원생 목록" onclick="location.href='../kinder/kinder_list'">
					<form action="./update_kinder" method="POST" name="frm" enctype="multipart/form-data">
						<table border="1">
							<tr>
								<th>원생 번호</th>
								<td>
									<input type="text" name="kinder_num" id="kinder_num" value="${kinder.kinder_num}" readonly="readonly">
								</td>
							</tr>
							<tr>
								<th>셔틀 버스 호차</th>
								<td>
									<select name="shuttle_num" id="shuttle_num">
										<option value="">-선택-</option>
										<c:if test="${shuttleList != null}">
											<c:forEach items="${shuttleList}" var="shuttle">
												<c:if test="${shuttle.shuttle_num == kinder.shuttle_num}">
													<option value="${shuttle.shuttle_num}" selected="selected">${shuttle.shuttle_num}호차] ${shuttle.shuttle_carNum}</option>
												</c:if>
												<c:if test="${shuttle.shuttle_num != kinder.shuttle_num}}">
													<option value="${shuttle.shuttle_num}">${shuttle.shuttle_num}호차] ${shuttle.shuttle_carNum}</option>
												</c:if>
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
												<c:if test="${homeTeacher.staff_num == kinder.staff_num}">
													<option value="${homeTeacher.staff_num}" selected="selected">${homeTeacher.staff_name}</option>
												</c:if>
												<c:if test="${homeTeacher.staff_num != kinder.staff_num}">
													<option value="${homeTeacher.staff_num}">${homeTeacher.staff_name}</option>
												</c:if>
											</c:forEach>
										</c:if>
									</select>
								</td>
							</tr>
							<tr>
								<th>원생 이름</th>
								<td>
									<input type="text" name="kinder_name" id="kinder_name" value="${kinder.kinder_name}">
								</td>
								
							</tr>
							<tr>
								<th>주민등록번호</th>
								<td>
									<input type="text" name="kinder_rrn1" id="kinder_rrn1" value="${kinder.kinder_rrn1}">-<input type="text" name="kinder_rrn2" id="kinder_rrn2" value="${kinder.kinder_rrn2}">
								</td>
							</tr>
							<tr>
								<th>주소</th>
								<td>
									<input type="text" name="kinder_addr" id="kinder_addr" value="${kinder.kinder_addr}">
								</td>
							</tr>
							<tr>
								<th>우편번호</th>
								<td>
									<input type="text" name="kinder_zipcode" id="kinder_zipcode" value="${kinder.kinder_zipcode}">
								</td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td>
									<input type="tel" name="kinder_tel" id="kinder_tel" value="${kinder.kinder_tel}">
								</td>
							</tr>
							<tr>
								<th>등록 일</th>
								<td>
									<input type="date" name="kinder_regdate" id="kinder_regdate" value="${kinder.kinder_regdate}">
								</td>
							</tr>
							<tr>
								<th>퇴원 일</th>
								<td>
									<input type="date" name="kinder_retireDate" id="kinder_retireDate" value="${kinder.kinder_retireDate}">
								</td>
							</tr>
							<tr>
								<th>재원 상태</th>
								<td>
									<select name="kinder_regYn" id="kinder_regYn">
										<c:if test="${kinder.kinder_regYn == 'Y'}">
											<option value="Y" selected="selected">재원</option>
											<option value="P">휴원</option>
											<option value="N">퇴원</option>
											<option value="G">졸업</option>
										</c:if>
										<c:if test="${kinder.kinder_regYn == 'P'}">
											<option value="Y">재원</option>
											<option value="P" selected="selected">휴원</option>
											<option value="N">퇴원</option>
											<option value="G">졸업</option>
										</c:if>
										<c:if test="${kinder.kinder_regYn == 'N'}">
											<option value="Y">재원</option>
											<option value="P">휴원</option>
											<option value="N" selected="selected">퇴원</option>
											<option value="G">졸업</option>
										</c:if>
										<c:if test="${kinder.kinder_regYn == 'G'}">
											<option value="Y">재원</option>
											<option value="P">휴원</option>
											<option value="N">퇴원</option>
											<option value="G" selected="selected">졸업</option>
										</c:if>
									</select>
								</td>
							</tr>
							<tr>
								<th>프로필 사진</th>
								<td>
									새로 업로드하실 경우에는 기존 사진에서 새로운 사진으로 대체됩니다.
									<input type="file" name="kinder_picFile" id="kinder_picFile">
									<div class="select_img">
										<img src="">
									</div>
								</td>
							</tr>
							<tr>
								<th>보유 알러지 정보</th>
								<td>
									<input type="text" id="allergy_info" readonly="readonly" style='text-align:center'>					
									<input type="hidden" id="allergy_code" name="allergy_code" value="${kinder.allergy_code}">
									<input type="button" value="입력" id="allergySel">
								</td>
							</tr>	
							<tr>
								<td colspan="2">
									<input type="button" value="수정" id="update"> 
								</td>
							</tr>
						</table>
					</form>
				</div>
			</section>
	</article>
<%@include file="../include/footer.jsp" %>
<script type="text/javascript">

function getAllergyCheck() {
	var allergy_code = document.getElementById('allergy_code').value;
	console.log(allergy_code);
	
	$.ajax({
		url : "/ius/kinder/get_allergy_check",
		type : "POST",
		data : {
			allergy_code : allergy_code
		},
		success: function(data) {
			$("#allergy_info").val(data.allergy_info);
			
		}
		
	})
};

getAllergyCheck();

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

		$("#allergySel").click(function(){
			url = "./select_allergy";
			window.open(url, "_blank_1", "toolbar=no, menubar=no, scrollbar=yes, resizeable=no, width=300, height=500");
		});	
		
	    $("#update").click(function(){
	    	
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
	
})


</script>	
</body>
</html>