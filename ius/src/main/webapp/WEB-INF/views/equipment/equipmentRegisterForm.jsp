<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시설(비품) 등록</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
<link type="text/css" rel="stylesheet" href="${path}/resources/css/equipment/equipmentRegisterForm.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="${path}/resources/js/equipment/equipmentRegisterForm.js"></script>
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>

	<article>
			<div id="title_bar">
				<p>경영 정보</p>
				<h3>시설(비품) 등록</h3>
			</div>
	
			
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<input type="button" value="목록으로" onclick="location.href='../equipment/equipment_list'">
					
					<form action="./equipment_register" method="POST" name="frm">
						<table border="1" class="register_form">
							<tr>
								<th>자산 번호</th>
								<td>
									<input type="text" value="${seqNum}" name="equipment_num" id="equipment_num" readonly="readonly">
								</td>
							</tr>
							<tr>
								<th>분류</th>
								<td>
									<input type="hidden" name="equip_cls_num" id="equip_cls_num">
									<input type="text" name="equip_cls_name" id="equip_cls_name" readonly="readonly">
									<input type="button" value="선택" id="equipment_cls_edit_btn">
								</td>
							</tr>
							<tr>
								<th>등록자</th>
								<td>
									<input type="text" value="${staff_name}" name="staff_name" id="staff_name" readonly="readonly">
									<input type="hidden" value="${staff_id}" name="staff_id" id="staff_id">
								</td>
							</tr>
							<tr>
								<th>취득일자</th>
								<td>
									<input type="date" name="equipment_regdate" id="equipment_regdate">
								</td>
							</tr>
							<tr>
								<th>비품명</th>
								<td>
									<input type="text" name="equipment_name" id="equipment_name">
								</td>
							</tr>
							<tr>
								<th>수량</th>
								<td>
									<input type="number" name="equipment_count" id="equipment_count" min="1" value="1">
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