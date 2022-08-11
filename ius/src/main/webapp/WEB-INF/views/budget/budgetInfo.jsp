<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예산 정보</title>
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
};

$(function(){
	$("#delete").click(function(){ // 삭제시 마스터 권한 확인.
		var master = getCookie("master");
		var budget_num = $("#budget_num").val();
		
		if (master == "N") { // 마스터 권한이 없는 경우.
			alert("권한이 없습니다.");
			return;
		} else if(master == "Y") { // 마스터 권한이 있는 경우.
			var input = confirm("정말 삭제하시겠습니까?");
			if (input === true) {  // 삭제 확인을 받은 후, 삭제 확인시 Ajax로 해당 데이터를 부모키로 가진 데이터가 있는지 조회후 있는 경우 삭제 불가 메시지 출력.
				$.ajax({
					url : "/ius/budget/count_finance_from_budget",
					type : "POST",
					data : {
						budget_num : budget_num
					},
					success: function(data) {
						if(data.result > 0) { // 해당 데이터가 있는 경우.
							alert("해당 예산 항목으로 생성된 재정 정보가 있어 삭제가 불가합니다.");
						} else {
							alert("삭제 되었습니다.");
							location.href='../budget/budget_delete?budget_num=' + budget_num;
						}
						
						}
						
					});
			};	
		}
	});
	
	$("#update").click(function(){ // 수정시 마스터 권한 확인.
		var master = getCookie("master");
		var budget_num = $("#budget_num").val();
		
		if (master == "N") { // 마스터 권한이 없는 경우.
			alert("권한이 없습니다.");
			return;
		} else if(master == "Y") { // 마스터 권한이 있는 경우.
				$.ajax({
					url : "/ius/budget/count_finance_from_budget",
					type : "POST",
					data : {
						budget_num : budget_num
					},
					success: function(data) {
						if(data.result > 0) { // 해당 데이터가 있는 경우.
							alert("해당 예산 항목으로 생성된 재정 정보가 있어 수정이 불가합니다.");
						} else {
							location.href='../budget/budget_update_form?budget_num=' + budget_num;
						}
						
						}
						
					});
				
		}
	});
	
	
});

</script>
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>

	<article>
			<div id="title_bar">
				<p>경영 정보</p>
				<h3>예산 정보</h3>
			</div>
	
			
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<input type="button" value="목록" onclick="location.href='../budget/budget_list'">
					<table border="1">
						<tr>
							<th>예산 번호</th>
							<th>년도</th>
							<th>구분</th>
							<th>항목</th>
							<th>총액</th>
						</tr>
						<tr>
							<td>	
								<input type="text" id="budget_num" readonly="readonly" value="${budget.budget_num}">
							</td>
							<td>${budget.budget_year}</td>
							<td>
								<c:if test="${budget.budget_iE == 'In'}">수입</c:if>
								<c:if test="${budget.budget_iE == 'Ex'}">지출</c:if>
							</td>
							<td>${budget.budget_cls}</td>
							<td>
								<fmt:formatNumber value="${budget.budget_total}" maxFractionDigits="3"/>원
							</td>
						</tr>
						<tr>
							<td colspan="5">
								<input type="button" value="삭제" id="delete">
								<input type="button" value="수정" id="update">
							</td>
						</tr>
					</table>
				</div>
			</section>
	</article>	

<%@include file="../include/footer.jsp" %>
</body>
</html>