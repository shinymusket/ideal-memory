<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전자 결재</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>	
<script type="text/javascript">
function getList() {
	$.ajax({
		url : "/ius/board/get_eWorks_list",
		type : "POST",
		data : {
			
		},
		success: function(data) {
			$("#list").text("");
			values = data.eworksBoardList;
			output = "<tr> <th>문서 번호</th> <th>문서 종류</th> <th>기안자</th> <th>문서 제목</th> <th>기안일</th> <th>결재일</th> </tr>";				
			$.each(values, function(index, value) {
				
				output += "<tr>";
				output += "<td>" + value.workNum + "</a></td>";
				output += "<td>" + value.workCategory + "</td>";
				output += "<td>" + value.staff_name + "</td>";
				output += "<td> <a href='../board/eWroks_info?doc_Sub=" + value.doc_Sub + "'>" + value.doc_Sub + "</a> </td>";
				output += "<td>" + value.workUpDate + "</td>";
				output += "<td>" + value.workDownDate + "</td>";
				output += "</tr>";
			});
			
			$("#list").html(output);
		}
		
	})
	
}
getList();

</script>
</head>

<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>

	<article>
			<div id="title_bar">
				<p>경영 정보</p>
				<h3>전자 결재</h3>
			</div>
	
			
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<h1>결재완료 문서</h1>
				<%-- 	<select name="SignDoc_year" id="SignDoc_year">
						<option value="">--년도--</option>
						<c:if test="${SignDocyearList}">
						
							<c:forEach items="${financeYearList}" var="financeYear">
							
								<option value="${financeYear}">${financeYear}년도</option>
								
							</c:forEach>	
						</c:if>
					</select> --%>
					
					<select name="doc_type" id="doc_type">
						<option value="total">전체</option>
						<option value="In">등록</option>
						<option value="Ex">삭제</option>
					</select>
					
					<input type="button" value="검색" id="yearSearch">
					
					<br>
						
					<input type="button" value="홈으로" onclick="location.href=''../main/''">
					
					<input type="button" value="기안 하기" onclick="location.href='../board/select_draft_form'">
				
					<table border="1" id="list"></table>
				</div>
			</section>
	</article>	
<%@include file="../include/footer.jsp" %>	
</body>
</html>