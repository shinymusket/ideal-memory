<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="${path}/resources/js/parent/parentRegisterForm.js"></script>
<title>학부모 정보 입력</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
<link type="text/css" rel="stylesheet" href="${path}/resources/css/parent/parentRegisterForm.css">
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>
	<article>
			<div id="title_bar">
				<p>원생 관리</p>
				<h3>학부모 정보 입력</h3>
			</div>
			
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<input type="button" value="학부모 목록" onclick="location.href='../parent/parent_list'">
					
					<form action="./parent_register" method="POST" name="frm">
						<table id="parent_register_tbl" border="1" class="list">
							<tr>
								<th>자녀 이름</th>
								<td>
									<input type="text" id="kinder_name" name="kinder_name" readonly="readonly">
									<input type="hidden" id="kinder_num" name="kinder_num">
									<input type="button" value="조회" id="select">
								</td>
							</tr>
							<tr>
								<th>가족 관계</th>
								<td>
									<select id="relation" name="relation">
										<option value="" selected="selected">-선택-</option>
										<option value="부">부</option>
										<option value="모">모</option>
									</select>
									<font id="check" size="2"></font>
								</td>
							</tr>
							<tr>
								<th>이름</th>
								<td>
									<input type="text" id="parent_name" name="parent_name">
								</td>
							</tr>
							<tr>
								<th>전화 번호</th>
								<td>
									<input type="text" id="parent_tel" name="parent_tel">
								</td>
							</tr>
							<tr>
								<th>이메일</th>
								<td>
									<input type="text" id="parent_email" name="parent_email">
								</td>
							</tr>
							<tr>
								<th>성별</th>
								<td>
									<input type="text" id="parent_sex" name="parent_sex" readonly="readonly">
								</td>
							</tr>
							<tr>
								<th>생년 월일</th>
								<td>
									<input type="date" id="parent_birth" name="parent_birth">
								</td>
							</tr>
							<tr>
								<td colspan="2" id="btnsTd">
									<input type="button" value="등록" id="register">
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