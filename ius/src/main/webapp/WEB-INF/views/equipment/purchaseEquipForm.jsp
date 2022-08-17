<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="${path}/resources/js/equipment/purchaseEquipForm.js"></script>
<title>구매품 등록</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
<link type="text/css" rel="stylesheet" href="${path}/resources/css/equipment/purchaseEquipForm.css">
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>
	
	<article>
			<div id="title_bar">
				<p>경영 정보</p>
				<h3>구매품 등록</h3>
			</div>
	
			
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<input type="button" value="목록으로" onclick="location.href='../equipment/equipment_list'">
					<form name="frm" action="./purchaseEquipRegister" method="POST">
						<table border="1" class="register_form">
							<tr>
								<th>구매 번호</th>
								<td>
									<input type="text" id="purchase_num" name="purchase_num" readonly="readonly" value="${purchaseSeq}"> 
								</td>
							<tr>
							<tr>
								<th>재정 코드</th>
								<td>
									<input type="text" id="finance_cls" name="finance_cls" readonly="readonly">
									<input type="hidden" id="finance_num" name="finance_num">
									<input type="button" value="조회" id="finance_select">
								</td>
							</tr>
							<tr>
								<th>구매자</th>
								<td>
									<input type="text" id="staff_name" name="staff_name" value="${pur_staff_name}" readonly="readonly">
									<input type="hidden" id="staff_num" name="staff_num" value="${pur_staff_num}">
								</td>
							</tr>
							<tr>
								<th>자산번호</th>
								<td>
									<input type="text" id="equipment_num" name="equipment_num" readonly="readonly" value="${equipSeqNum}">
								</td>
							</tr>
							<tr>
								<th>분류 항목</th>
								<td>
									<input type="text" id="equip_cls_name" name="equip_cls_name" readonly="readonly">
									<input type="hidden" id="equip_cls_num" name="equip_cls_num">
									<input type="button" id="equip_cls_sel" value="선택">
								</td>
							</tr>
							<tr>
								<th>비품명</th>
								<td>
									<input type="text" id="equipment_name" name="equipment_name">
								</td>
							</tr>
							<tr>
								<th>구매 일자</th>
								<td>
									<input type="date" id="purchase_date" name="purchase_date">
								</td>
							</tr>
							<tr>
								<th>구매 가격</th>
								<td>
									<input type="text" id="purchase_price" name="purchase_price">
								</td>
							</tr>
							<tr>
								<th>구매 수량</th>
								<td>
									<input type="number" id="purchase_count" name="purchase_count" value="1" min="1">
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