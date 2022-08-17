<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="path" value="${pageContext.request.contextPath}"/>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="${path}/resources/js/parent/parentList.js"></script>
<title>학부모 관리</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
<link type="text/css" rel="stylesheet" href="${path}/resources/css/parent/parentList.css">
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>
	<article>
			<div id="title_bar">
				<p>원생 관리</p>
				<h3>학부모 관리</h3>
			</div>
	
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<div id="controllBtns">
						<input type="button" value="원생 관리" onclick="location.href='../kinder/kinder_list'">
						<input type="button" value="학부모 정보 입력" onclick="location.href='../parent/parent_register_form'">
						<select id="classNumber" onchange="select_by_class()">
							<c:if test="${classList != null}">
								<option value="">전체</option>
								<c:forEach items="${classList}"  var="classInfo">
									<option value="${classInfo.class_number}">${classInfo.class_name}</option>
								</c:forEach>
							</c:if>
						</select>
					</div>
					
					<div id="kinderBox" style="float : left;">
						<table id="kinderList" class="list" border="1"></table>
					</div>
					
					<table id="kinderInfo" class="list" border="1" style="float : left; display : none;">
						<tr>
							<th>원생 명</th>
							<td>
								<input type="text" id="kinder_name" readonly="readonly" style="text-align : center;">
								<input type="hidden" id="kinder_num" readonly="readonly">
							</td>
						</tr>
						<tr>	
							<th>학급 명</th>
							<td>
								<input type="text" id="class_name" readonly="readonly" style="text-align : center;">
							</td>
						</tr>
						<tr>
							<th>담임 교사</th>
							<td>
								<input type="text" id="staff_name" readonly="readonly" style="text-align : center;">
							</td>
						</tr>
					</table>
					
					<div id="parentInfo" style="float : left;">
						<table id="father" border="1" style="float : left; display : none;">
							<tr>
								<th>가족 관계</th>
								<td>
									<input type="text" class="relation" readonly="readonly" style="text-align : center;">
								</td>
							</tr>
							<tr>
								<th>성명</th>
								<td>
									<input type="text" class="parent_name" readonly="readonly" style="text-align : center;">
								</td>
							</tr>
							<tr>
								<th>연락처</th>
								<td>
									<input type="text" class="parent_tel" readonly="readonly" style="text-align : center;">
								</td>
							</tr>
							<tr>
								<th>이메일</th>
								<td>
									<input type="text" class="parent_email" readonly="readonly" style="text-align : center;">
								</td>
							</tr>
							<tr>
								<th>성별</th>
								<td>
									<input type="text" class="parent_sex" readonly="readonly" style="text-align : center;">
								</td>
							</tr>
							<tr>
								<th>생년 월일</th>
								<td>
									<input type="date" class="parent_birth" readonly="readonly" style="text-align : center;"> 
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<input type="button" value="정보 수정" class="update">
									<input type="button" value="수정 정보 등록" class="updateRegister" style="display : none;">
									<input type="button" value="정보 수정 취소" class="updateCancel" style="display : none;">
									<input type="button" value="삭제" class="delete">
								</td>
							</tr>	
						</table>
						
						
						<table id="mather" border="1" style="float : left; display : none;">
							<tr>
								<th>가족 관계</th>
								<td>
									<input type="text" class="relation" readonly="readonly" style="text-align : center;">
								</td>
							</tr>
							<tr>
								<th>성명</th>
								<td>
									<input type="text" class="parent_name" readonly="readonly" style="text-align : center;">
								</td>
							</tr>
							<tr>
								<th>연락처</th>
								<td>
									<input type="text" class="parent_tel" readonly="readonly" style="text-align : center;">
								</td>
							</tr>
							<tr>
								<th>이메일</th>
								<td>
									<input type="text" class="parent_email" readonly="readonly" style="text-align : center;">
								</td>
							</tr>
							<tr>
								<th>성별</th>
								<td>
									<input type="text" class="parent_sex" readonly="readonly" style="text-align : center;">
								</td>
							</tr>
							<tr>
								<th>생년 월일</th>
								<td>
									<input type="text" class="parent_birth" readonly="readonly" style="text-align : center;"> 
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<input type="button" value="정보 수정" class="update">
									<input type="button" value="수정 정보 등록" class="updateRegister" style="display : none;">
									<input type="button" value="정보 수정 취소" class="updateCancel" style="display : none;">
									<input type="button" value="삭제" class="delete">
								</td>
							</tr>
						</table>	
					</div>
					

					
					
				</div>
			</section>
	</article>
<%@include file="../include/footer.jsp" %>
</body>
</html>