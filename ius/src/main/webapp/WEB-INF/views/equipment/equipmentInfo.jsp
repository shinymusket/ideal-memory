<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시설(비품) 정보</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
function getCookie(name) {	// 저장된 쿠키 가져오기
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
}
	
$(function(){
	$("#update").click(function(){ // 수정시 시설 권한이 없으면 수정 불가하며 본인의 글인 경우만 수정 가능. (마스터 권한은 본인의 글이 아니더라도 삭제 수정 가능.)
		var master = getCookie("master");
		var facility = getCookie("facility");
		var equipment_num = $("#equipment_num").val();
		
		var log_staff_id = $("#log_staff_id").val();
		var staff_id = $("#staff_id").val();
		
		
		if(master == "Y") { // 마스터(관리자) 권한이 있는 경우
			location.href = "../equipment/equipment_update?equipment_num=" + equipment_num;
		} else if(master == "N") { // 마스터(관리자) 권한이 없는 경우
			if(facility == "N") { // 시설 권한이 없는 경우.
				alert("권한이 없습니다.");
				return;
			} else if(facility == "Y") { // 시설 권한이 있는 경우 - 본인 작성 글인지 확인.
				if (log_staff_id != staff_id) {
					alert("본인이 작성한 글이 아닌 경우 수정이 불가합니다.");
					return;
				} else {
					location.href = "../equipment/equipment_update?equipment_num=" + equipment_num;
				}
			}
		};
	});
	
	$("#delete").click(function(){ // 삭제시 시설 권한이 없으면 삭제 불가하며 본인의 글인 경우만 삭제 가능. (마스터 권한은 본인의 글이 아니더라도 삭제 수정 가능.)
		var master = getCookie("master");
		var facility = getCookie("facility");
		var equipment_num = $("#equipment_num").val();
		
		var log_staff_id = $("#log_staff_id").val();
		var staff_id = $("#staff_id").val();
		
		
		if(master == "Y") { // 마스터(관리자) 권한이 있는 경우
			var input = confirm("정말 삭제하시겠습니까?");
			if (input === true) {
				alert("삭제 되었습니다.");
				location.href = "../equipment/equipment_delete?equipment_num=" + equipment_num;
			};
			
		} else if(master == "N") { // 마스터(관리자) 권한이 없는 경우
			if(facility == "N") { // 시설 권한이 없는 경우.
				alert("권한이 없습니다.");
				return;
			} else if(facility == "Y") { // 시설 권한이 있는 경우 - 본인 작성 글인지 확인.
				if (log_staff_id != staff_id) {
					alert("본인이 작성한 글이 아닌 경우 삭제 불가합니다.");
					return;
				} else {
					var input = confirm("정말 삭제하시겠습니까?");
					if (input === true) {
						alert("삭제 되었습니다.");
						location.href = "../equipment/equipment_delete?equipment_num=" + equipment_num;
					};
				}
			}
		};
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
				<h3>시설(비품) 정보</h3>
			</div>
	
			
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<input type="button" value="목록으로" onclick="location.href='../equipment/equipment_list'">
					<table border="1">
						<tr>
							<th colspan="2">시설(비품) 자산 코드</th>
							<td colspan="2">
								<input type="hidden" id="log_staff_id" value="${staff_id}">
								<input type="text" id="equipment_num" value="${equipment.equipment_num}" readonly="readonly">
							</td>
						</tr>
						<tr>
							<th>등록자</th>
							<td>
							${equipment.staff_name}
							<input type="hidden" id="staff_id" value="${equipment.staff_id}">
							</td>
							<th>분류항목</th>
							<td>${equipment.equip_cls_name}</td>
						</tr>
						<tr>
							<th>시설(비품) 명</th>
							<td>${equipment.equipment_name}</td>
							<th>수량</th>
							<td>${equipment.equipment_count}</td>
						</tr>
						<tr>
							<th colspan="2">등록 날짜</th>
							<td colspan="2">${equipment.equipment_regdate}</td>
						</tr>
						<c:if test="${equipment.equipment_cate eq '구매품'}">
							<tr>
								<td colspan="4">구매품</td>
							</tr>
						</c:if>
						<tr>
							<td colspan="4">
								<input type="button" value="수정" id="update">
								<input type="button" value="삭제" id="delete">
							</td>
						</tr>
					</table>
				</div>
			</section>
	</article>	

<%@include file="../include/footer.jsp" %>	
</body>
</html>