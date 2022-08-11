<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시설(비품) 정보 수정</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(function(){
		$("#equipment_cls_edit_btn").click(function(){
			url = "./equipment_class_edit";
			window.open(url, "_blank_1", "toolbar=no, menubar=no, scrollbar=yes, resizeable=no, width=550, height=400");
		});
		
		$("#update").click(function(){
			if ($("#equip_cls_num").val().trim() === "") {
				alert("분류 항목을 선택해주세요.");
				$("#equip_cls_num").val().focus();
				return;
			};
			if ($("#equipment_name").val().trim() === "") {
				alert("시설(비품) 명을 입력해주세요.")
				$("#equipment_name").val().focus();
				return;
			};
			
			if ($("#equipment_name").val().length > 10) {
				alert("시설(비품) 명은 10자이하여야 합니다.")
				$("#equipment_name").val().focus();
				return;	
			};
			
			frm.submit();
			
		});
		
	})

</script>
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>
	
	<article>
			<div id="title_bar">
				<p>경영 정보</p>
				<h3>시설(비품) 정보 수정</h3>
			</div>
	
			
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<input type="button" value="목록으로" onclick="location.href='../equipment/equipment_list'">
					<form action="./equipment_update" method="POST" name="frm">
						<table border="1">
							<tr>
								<th colspan="2">자산 번호</th>
								<td colspan="2">
									<input type="text" value="${equipment.equipment_num}" name="equipment_num" id="equipment_num" readonly="readonly">
								</td>
							</tr>
							<tr>
								<th>등록자</th>
								<td>
									<input type="text" value="${equipment.staff_name}" name="staff_name" id="staff_name" readonly="readonly">
									<input type="hidden" value="${equipment.staff_id}" name="staff_id" id="staff_id">
								</td>
								<th>분류</th>
								<td>
									<input type="hidden" name="equip_cls_num" id="equip_cls_num" value="${equipment.equip_cls_num}">
									<input type="text" name="equip_cls_name" id="equip_cls_name" readonly="readonly" value="${equipment.equip_cls_name}">
									<input type="button" value="선택" id="equipment_cls_edit_btn">
								</td>
							</tr>
							<tr>
								<th>비품명</th>
								<td>
									<input type="text" name="equipment_name" id="equipment_name" value="${equipment.equipment_name}">
								</td>
								<th>수량</th>
								<td>
									<input type="number" name="equipment_count" id="equipment_count" min="1" value="${equipment.equipment_count}">
								</td>
							</tr>
							<tr>
								<th colspan="2">취득일자</th>
								<td colspan="2">
									<input type="date" name="equipment_regdate" id="equipment_regdate" value="${equipment.equipment_regdate}">
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<input type="button" value="수정" id="update">
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