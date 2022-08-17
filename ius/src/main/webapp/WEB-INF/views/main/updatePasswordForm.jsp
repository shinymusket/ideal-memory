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
<script type="text/javascript" src="${path}/resources/js/main/updatePasswordForm.js"></script>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
<link type="text/css" rel="stylesheet" href="${path}/resources/css/main/updatePasswordForm.css">
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
					<input type="button" value="내 정보 보기" onclick="location.href='../main/my_staff_info'">
					<form action="./update_password" method="POST">
						<table border="1" id="updatePwdTbl">
							<tr>
								<th>
									<label for="originPassword">기존 비밀번호</label>
								</th>
								<td>
									<input type="hidden" id="staff_id" value="${staff_id}">
									<input type="password" id="originPassword">
								</td>
							</tr>
							<tr>
								<th>
									<label for="newPassword">새 비밀번호</label>
								</th>
								<td>
									
									<input type="password" id="newPassword" name="newPassword">
								</td>
							</tr>
							<tr>
								<th>
									<label for="newPasswordChk">새 비밀번호 확인</label>
								</th>
								<td>
									<input type="password" id="newPasswordChk">
								</td>
							</tr>
							<tr>
								<td id="btnsTd" colspan="2">
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