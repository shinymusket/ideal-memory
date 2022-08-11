<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경하기</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
$(function(){
	$("#update").click(function(){
		var staff_id = $("#staff_id").val();
		var originPassword = $("#originPassword").val();
		var newPassword = $("#newPassword").val();
		var newPasswordChk = $("#newPasswordChk").val();
		
		if (originPassword == "") {
			alert("기존 비밀번호를 입력하세요.");
			originPassword.focus();
			return;
		};
		if (newPassword == "") {
			alert("새 비밀번호를 입력하세요.");
			newPassword.focus();
			return;
		};
		if (newPasswordChk == "") {
			alert("새 비밀번호 확인란을 입력하세요.");
			newPasswordChk.focus();
			return;
		};
		if (newPassword != newPasswordChk) {
			alert("새 비밀번호가 다릅니다.");
			return;
		};
		
		$.ajax({
			url : "/ius/main/check_origin_password",
			type : "POST",
			data : {
				staff_id : staff_id,
				originPassword : originPassword
			},
			success: function(data) {
				if(data.result == 0) {
					alert("기존 비밀번호가 틀렸습니다.");	
				} else {
					alert("비밀번호가 변경되었습니다. 새 비밀번호로 로그인하세요.")
					$("form").submit();
				}
				
			}
			
		})
		
		
		
	});
	
})	



</script>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css?">
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>
	<article>
			<div id="title_bar">
				<p>내 정보</p>
				<h3>비밀번호 변경하기</h3>
			</div>
	
			
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<form action="./update_password" method="POST">
						<table border="1">
							<tr>
								<td>
									<input type="hidden" id="staff_id" value="${staff_id}">
									<label for="originPassword">기존 비밀번호</label>
									<input type="password" id="originPassword">
								</td>
							</tr>
							<tr>
								<td>
									<label for="newPassword">새 비밀번호</label>
									<input type="password" id="newPassword" name="newPassword">
								</td>
							</tr>
							<tr>
								<td>
									<label for="newPasswordChk">새 비밀번호 확인</label>
									<input type="password" id="newPasswordChk">
								</td>
							</tr>
							<tr>
								<td>
									<input type="button" id="update" value="변경하기">
								</td>	
							</tr>	
						</table>
					</form>
				</div>
			</section>
	</article>	
<%@include file="../include/footer.jsp" %>
</body>
</html>